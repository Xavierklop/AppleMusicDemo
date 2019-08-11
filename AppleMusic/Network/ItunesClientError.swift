//
//  ItunesError.swift
//  AppleMusic
//
//  Created by Hao Wu on 05.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

enum ItunesClientError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case dataDecodeFailure
}


