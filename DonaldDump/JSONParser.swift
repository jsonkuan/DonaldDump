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
    
    func loadDataForQuery(_ query: String, closure: @escaping () -> Void) {
        dataStore.searchQueryResults = []
        
        let url = "https://api.tronalddump.io/search/quote?query=\(query)"
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
                                if let container = json["_embedded"] as? [String: Any],
                                    let dictionaries = container["quotes"] as? [[String: Any]] {
                                    for dictionary in dictionaries {
                                        if let value = dictionary["value"] as? String,
                                            let date = dictionary["appeared_at"] as? String {
                                            let endIndex = date.index(date.endIndex, offsetBy: -9)
                                          self.dataStore.searchQueryResults.append(Quote(phrase: value, date: date.substring(to: endIndex)))
                                            closure()
                                        }
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
    
    func getFirstWord(_ tag: String) -> String {
        let tags = tag.components(separatedBy: " ")
        return tags.first!
    }
    
    func loadQuoteForTag(_ tag: String) {
        let url = "https://api.tronalddump.io/search/quote?query=\(getFirstWord(tag))"
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
                                if let container = json["_embedded"] as? [String: Any],
                                    let dictionaries = container["quotes"] as? [[String: Any]] {
                                    for dictionary in dictionaries {
                                        if let value = dictionary["value"] as? String,
                                            let date = dictionary["appeared_at"] as? String {
                                            let endIndex = date.index(date.endIndex, offsetBy: -9)
                                            self.dataStore.tagRelatedQuotes.append(Quote(phrase: value, date: date.substring(to: endIndex)))
                                        }
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
                                if let quotes = json["value"] as? String,
                                    let date = json["appeared_at"] as? String {
                                    
                                    var data: [Quote] = []
                                    let endIndex = date.index(date.endIndex, offsetBy: -9)
                                    data.append(Quote(phrase: quotes, date: date.substring(to: endIndex)))
                                    self.dataStore.quotesArray = data
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

