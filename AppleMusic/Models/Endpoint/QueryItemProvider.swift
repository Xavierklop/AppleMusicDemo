//
//  QueryItemProvider.swift
//  AppleMusic
//
//  Created by Hao Wu on 01.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}
