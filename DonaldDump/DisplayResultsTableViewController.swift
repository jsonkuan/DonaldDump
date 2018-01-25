//
//  DisplayResultsTableViewController.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-15.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class DisplayResultsTableViewController: UITableViewController {

    let dataStore = DataStore.sharedStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.tagRelatedQuotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! MyTableViewCell

        // Configure the cell...
        cell.quoteLabel.text = dataStore.tagRelatedQuotes[indexPath.row].phrase
        cell.dateLabel.text = dataStore.tagRelatedQuotes[indexPath.row].date
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
  }
}
