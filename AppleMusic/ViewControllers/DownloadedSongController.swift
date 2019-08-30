//
//  DownloadedSongController.swift
//  AppleMusic
//
//  Created by Hao Wu on 19.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AVKit

class DownloadedSongController: UITableViewController {
    
    private struct Constants {
        static let SongCellHeight: CGFloat = 80
    }
    
    var dataController: DataController!
    var dataScource = DownloadedSongDataSource()
    var fetchedResultsController: NSFetchedResultsController<SongEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Downloaded Songs"
        setUpFetchedReultsContoller()
        tableView.dataSource = dataScource
        dataScource.dataController = dataController
        dataScource.tableView = tableView
        dataScource.fetchedResultsController = fetchedResultsController
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchedResultsController = nil
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.SongCellHeight
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // test
        print("\nBefore get songEntity\n")
        let songEntity = 
        print("\nAfter get songEntity\n")
        playDownload(songEntity)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func setUpFetchedReultsContoller() {
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescription]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not performed: \(error.localizedDescription).")
        }
    }
    
    func playDownload(_ songEntity: SongEntity) {
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        guard let urlString = songEntity.previewDestinationURL else {
            print("songEntity's previewDestinationURL is nil!")
            return
        }
        // test
        print("urlString is \(urlString)")
        
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            playerViewController.player = player
            player.play()
        }
    }
    
}

extension DownloadedSongController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
            break
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            break
        }
    }
}
