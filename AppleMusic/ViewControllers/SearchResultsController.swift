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
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = dataSource
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search artist"
        definesPresentationContext = true
        self.title = "Search"
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
        
        albumListController.dataController = dataController
        ItunesClient.lookupArtist(by: artist.id) {[weak self] (artist, error) in
            if artist != nil {
                albumListController.artist = artist
            } else {
                self?.showAlert(title: "Bad network connection", message: "Please try to search artist later.")
            }
            
        }
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
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
