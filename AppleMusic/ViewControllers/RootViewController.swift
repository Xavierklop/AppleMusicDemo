//
//  ViewController.swift
//  AppleMusic
//
//  Created by Hao Wu on 22.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test
//        let searchEndpoint = Itunes.search(term: "taylor swift", media: .music(entity: .musicArtist, attribute: .artistTerm))
//        print(searchEndpoint.request)
//
//        print("*******************\n")
//
//        let lookupEndpoint = Itunes.lookup(id: 159260351, entity: MusicEntity.album)
//        print(lookupEndpoint.request)
        ItunesClient.getArtistAlbums(by: 159260351) { (results, error) in
            print("test")
        }
    }


}

