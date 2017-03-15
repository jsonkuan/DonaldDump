//
//  Quote.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-13.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class Quote: NSObject {
    let phrase: String
    let date: String
    init(phrase: String, date: String) {
        self.phrase = phrase
        self.date = date 
    }
}
