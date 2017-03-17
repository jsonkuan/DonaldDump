//
//  SearchTableViewController.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-10.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit
import OneSignal

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController!
    let dataStore = DataStore.sharedStore
    var searchResult: [Quote] = []
    let parser = JSONParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by quote"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        tableView.reloadData()
    }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseSearchResult {
            return dataStore.searchQueryResults.count
        } else {
            return dataStore.tagsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if shouldUseSearchResult {
            cell.textLabel?.text = dataStore.searchQueryResults[indexPath.row].phrase
        } else {
            cell.textLabel?.text = dataStore.tagsArray[indexPath.row].label
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive {
            return "Search Results:"
        } else {
            return "Suggestions by tag: "
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let query = searchController.searchBar.text?.lowercased() {
            parser.loadDataForQuery(query) {
                self.searchResult = self.dataStore.searchQueryResults.filter { $0.phrase.lowercased().contains(query) }
                self.dataStore.searchQueryResults = self.searchResult
                self.tableView.reloadData()
            }
        }
    }
    
    var shouldUseSearchResult: Bool {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                return false
            }
        }
        return searchController.isActive
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayResults" {
            if let cell = sender as? UITableViewCell,
                let tag = cell.textLabel!.text {
                dataStore.tagRelatedQuotes = [] 
                parser.loadQuoteForTag(tag)
            }
        }
    }
}
