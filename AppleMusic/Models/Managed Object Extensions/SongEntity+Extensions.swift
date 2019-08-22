//
//  SongEntity+Extensions.swift
//  AppleMusic
//
//  Created by Hao Wu on 22.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import CoreData

extension SongEntity {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
