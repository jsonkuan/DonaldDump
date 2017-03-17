//
//  RandomQuoteViewController.swift
//  DonaldDump
//
//  Created by Jason Kuan on 2017-03-13.
//  Copyright © 2017 jsonkuan. All rights reserved.
//

import UIKit

class RandomQuoteViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    var dataStore = DataStore.sharedStore
    let parser = JSONParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.loadRandomQuote()
        parser.loadTags()
    }

    @IBAction func getRandomQuote(_ sender: UIButton) {
        parser.loadRandomQuote()
        quoteLabel.text = "'' " + dataStore.quotesArray[0].phrase + " ''" + "\n\n" + dataStore.quotesArray[0].date
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
