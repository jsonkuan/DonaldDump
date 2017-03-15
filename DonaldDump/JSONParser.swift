//
//  JSONParser.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-13.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

enum SerializationError: Error {
    case missing(String)
    case invalid(String)
}

class JSONParser: NSObject {
    
    let dataStore = DataStore.sharedStore
    
    func loadTags() {
        let url = "https://api.tronalddump.io/tags"
        if let safeUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let json = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            DispatchQueue.main.async {
                                if let tagArray = json["_embedded"] as? [String] {
                                    for tag in tagArray {
                                        self.dataStore.tagsArray.append(Tag(label: tag))
                                    }
                                }
                            }
                        } else {
                            throw SerializationError.invalid("Failed to cast from json.")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse json: \(parseError).")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create url.")
        }
    }
    
    func loadRandomQuote() {
        let url = "https://api.tronalddump.io/random/quote"
        if let safeUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (maybeData: Data?, response: URLResponse?, error: Error?) in
                if let actualData = maybeData {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let json = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String:Any] {
                            DispatchQueue.main.async {
                                if let quotes = json["value"] as? String {
                                    self.dataStore.quotesArray.append(Quote(phrase: quotes))
                                }
                            }
                        } else {
                            throw SerializationError.invalid("Failed to cast from json.")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse json: \(parseError).")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create url.")
        }
    }
}
