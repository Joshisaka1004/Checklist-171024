//
//  categoryItemsVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoryItemsVC: UITableViewController {

    var categoriesItemsData = [ItemsData]()
    var delegate: categoriesVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        //load()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !categoriesItemsData.isEmpty {
            return categoriesItemsData.count
        } else {
            return 0
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = categoriesItemsData[indexPath.row].names
        return myCell
    }
    @IBAction func done(_ sender: Any) {
        let myErsatz = "Hakyuu!"
        categoriesItemsData[0].names = myErsatz
        delegate.feedMyTable(myParam: "22222222")
        tableView.reloadData()
    }
}




