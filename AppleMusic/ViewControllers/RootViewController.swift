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
//        ItunesClient.lookupArtist(by: 159260351) { (result, error) in
//            print("test")
//            print(result?.id)
//            print(result?.albums[0].censoredName)
//        }
        
        ItunesClient.lookupAlbum(by: 1440935467) { (result, error) in
            print("test")
            print(result?.name)
            print(result?.songs[0].censoredName)
        }
    }


}

