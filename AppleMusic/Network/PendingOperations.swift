//
//  PendingOperations.swift
//  AppleMusic
//
//  Created by Hao Wu on 13.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class PendingOperations {
    var downloadInProcess = [IndexPath: Operation]()
    let downQueue = OperationQueue()
}
