//
//  ViewController.swift
//  AppleMusic
//
//  Created by Hao Wu on 22.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var dataController: DataController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarVC = segue.destination as! UITabBarController
        
        let downloadNavigationVC = tabBarVC.viewControllers?.last as! UINavigationController
        let searchNavigationVC = tabBarVC.viewControllers?.first as! UINavigationController
        
        let searchArtistVC = searchNavigationVC.topViewController as! SearchResultsController
        let downloadedSongVC = downloadNavigationVC.topViewController as! DownloadedSongController
        
        downloadedSongVC.dataController = dataController
        searchArtistVC.dataController = dataController
    }
}

