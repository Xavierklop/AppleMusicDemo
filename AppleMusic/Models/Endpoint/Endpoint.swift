//
//  Endpoint.swift
//  AppleMusic
//
//  Created by Hao Wu on 30.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryIterm: [URLQueryItem] { get }
}

extension Endpoint {
    var urlCompoents: URLComponents {
        var compoents = URLComponents(string: base)!
        compoents.path = path
        compoents.queryItems = queryIterm
        
        return compoents
    }
    
    var request: URLRequest {
        let url = urlCompoents.url!
        return URLRequest(url: url)
    }
}

enum Itunes {
    case search(term: String, media: ItunesMedia?)
    case lookup(id: Int, entity: ItunesEntity?)
}

extension Itunes: Endpoint {
    var base: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/search"
        case .lookup: return "/lookup"
        }
    }
    
    var queryIterm: [URLQueryItem] {
        switch self {
        case .search(let term, let media):
            var result = [URLQueryItem]()
            
            let searchIterm = URLQueryItem(name: "term", value: term)
            result.append(searchIterm)
            
            if let media = media {
                let mediaIterm = URLQueryItem(name: "media", value: media.description)
                result.append(mediaIterm)
                
                if let entityQueryItem = media.entityQueryItem {
                    result.append(entityQueryItem)
                }
                
                if let attributeQueryItem = media.attributeQueryItem {
                    result.append(attributeQueryItem)
                }
            }
            return result
        case .lookup(let id, let entity): return [URLQueryItem(name: "id", value: id.description), URLQueryItem(name: "entity", value: entity?.entityName)]
        }
    }
}
