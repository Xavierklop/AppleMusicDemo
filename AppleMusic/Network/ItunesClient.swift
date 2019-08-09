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
        var artists: [Artist] = []
        
        taskForGETRequest(request: request, response: ItunesSearchResponse.self) { (response, error) in
            if let response = response {
                let resultes = response.results
                resultes.forEach({ (itunesArtist) in
                    let artist  = Artist(id: itunesArtist.artistId, name: itunesArtist.artistName, primaryGenre: itunesArtist.primaryGenreName, albums: [])
                    artists.append(artist)
                })
                completion(artists, nil)
            } else {
                completion([], .dataDecodeFailure)
            }
        }
    }
    
    class func getArtistAlbums(by id: Int, completion: @escaping ([Album], ItunesError?) -> Void) {
        let request = Itunes.lookup(id: id, entity: MusicEntity.album).request
        
        taskForGETRequest(request: request, response: AlbumLookupResponse.self) { (response, error) in
            if let response = response {
                let results = response.results
                // TODO: - finish to get albums
            } else {
                completion([], .dataDecodeFailure)
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
