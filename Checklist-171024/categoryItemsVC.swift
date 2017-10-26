//
//  categoryItemsVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoryItemsVC: UITableViewController {

    var myItems = [CategoriesData]()
    var index: Int!
    var delegate: categoriesVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(index!)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems[index].items.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = myItems[index].items[indexPath.row].names
        return myCell
    }
    @IBAction func done(_ sender: Any) {
        let text = ItemsData()
        text.names = "200"
        myItems[index].items.append(text)
        tableView.reloadData()
        delegate.save()
    }
}




