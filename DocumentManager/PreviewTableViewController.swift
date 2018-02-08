//
//  PreviewTableViewController.swift
//  DocumentManager
//
//  Created by Bob De Kort on 2/4/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class PreviewTableViewController: UITableViewController {
    
    let url = "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json"
    
    var collections: [Collection]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    var valueToPass: Collection?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Overview"
        NetworkLayer.shared.getCollections(url: url) { (collections) in
            self.collections = collections
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let collections = collections {
            return collections.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PreviewTableViewCell
        cell.collection = collections?[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "imagesSegue") {
            let destinationVC = segue.destination as? ImagesTableViewController
            destinationVC?.collection = collections![(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
