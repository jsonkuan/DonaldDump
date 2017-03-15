//
//  DataStore.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-13.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class DataStore: NSObject {
    static let sharedStore: DataStore = {
        let instance = DataStore()
        return instance
    }()
    
    var quotesArray: [Quote] = []
    var tagsArray: [String] = []
}
