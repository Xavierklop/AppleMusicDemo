//
//  DataController.swift
//  AppleMusic
//
//  Created by Hao Wu on 18.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescroption, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext(interval: 3)
            completion?()
        }
    }
    
}

extension DataController {
    func autoSaveViewContext(interval: TimeInterval = 30) {
        guard interval > 0 else {
            print("Cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("In dataController, auto save failed. Error: \(error.localizedDescription)")
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext()
        }
    }
}
