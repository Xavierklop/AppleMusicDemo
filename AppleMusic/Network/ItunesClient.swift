//
//  ItunesClient.swift
//  AppleMusic
//
//  Created by Hao Wu on 05.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class ItunesClient {
    
    class func searchArtist(by term: String, completion: @escaping ([Artist] , ItunesError?) -> Void) {
        
        let request = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm)).request
        
        taskForGETRequest(request: request, response: ItunesSearchResponse.self) { (response, error) in
            if let response = response {
                let resultes = response.results
                
                let artists = resultes.compactMap { Artist(id: $0.artistId, name: $0.artistName, primaryGenre: $0.primaryGenreName, albums: []) }
                
                completion(artists, nil)
            } else {
                completion([], .dataDecodeFailure)
            }
        }
    }
    
    class func lookupArtist(by id: Int, completion: @escaping (Artist?, ItunesError?) -> Void) {
        let request = Itunes.lookup(id: id, entity: MusicEntity.album).request
        
        taskForGETRequest(request: request, response: AlbumLookupResponse.self) { (response, error) in
            if let response = response {
                let results = response.results
                guard let artistInfo = results.first else {
                    completion(nil, .dataDecodeFailure)
                    return
                }
                let artist = Artist(id: artistInfo.artistID, name: artistInfo.artistName, primaryGenre: artistInfo.primaryGenreName, albums: [])
                
                let albumsInfo = results[1..<results.count]
                
                let albums = albumsInfo.compactMap({ (albumInfo) -> Album in
                    var album: Album?
                    
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                    
                    if let id = albumInfo.collectionID, let name = albumInfo.collectionName, let censoredName = albumInfo.collectionCensoredName, let artworkUrl = albumInfo.artworkUrl100, let numberOfTracks = albumInfo.trackCount, let releaseDateString = albumInfo.releaseDate, let isExplicitString = albumInfo.collectionExplicitness,let releaseDate = formatter.date(from: releaseDateString) {
                        let artistName = albumInfo.artistName
                        let primaryGenre = albumInfo.primaryGenreName
                        let isExplicit = isExplicitString == "notExplicit" ? false : true
                        
                        album = Album(id: id, artistName: artistName, name: name, censoredName: censoredName, artworkUrl: artworkUrl, isExplicit: isExplicit, numberOfTracks: numberOfTracks, releaseDate: releaseDate, primaryGenre: primaryGenre)
                    }
                    return album!
                })
                artist.albums = albums
                completion(artist, nil)
            } else {
                completion(nil, .dataDecodeFailure)
            }
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(request: URLRequest, response: ResponseType.Type, completion: @escaping (ResponseType?, ItunesError?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, .requestFailed)
                }
                return
            }
            guard httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(nil, .responseUnsuccessful)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, .invalidData)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                // test
                print("error is below")
                print(error)
                print("++++++++++++++++++")
                
                DispatchQueue.main.async {
                    completion(nil, .dataDecodeFailure)
                }
            }
        }
        task.resume()
    }
}
