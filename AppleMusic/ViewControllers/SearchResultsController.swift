//
//  SearchResultsController.swift
//  AppleMusic
//
//  Created by Hao Wu on 23.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let dataSource = SearchResultsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = dataSource
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }

    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAlbums" else {
            print("No selected artist")
            return
        }
        guard let selectedindexPath = tableView.indexPathForSelectedRow else {
            print("No selected Row")
            return
        }
        let artist = dataSource.artist(at: selectedindexPath)
        let albumListController = segue.destination as! AlbumListController
        
        ItunesClient.lookupArtist(by: artist.id) { (artist, error) in
            albumListController.artist = artist
            albumListController.tableView.reloadData()
        }
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        ItunesClient.searchArtist(by: searchController.searchBar.text!) {[weak self] (artists, error) in
            self?.dataSource.update(with: artists)
            self?.tableView.reloadData()
        }
        
    }
}
