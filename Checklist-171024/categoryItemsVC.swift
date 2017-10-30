//
//  categoryItemsVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoryItemsVC: UITableViewController, itemModifierDelegate {

    var myItems = [CategoriesData]()
    var index: Int!
    var delegate: categoriesVC!
    var myTitle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = myTitle
        if title == "NOCH KEINE KATEGORIE!" {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems[index].items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if !myItems[index].items.isEmpty {
            myCell.textLabel?.text = myItems[index].items[indexPath.row].names
        }
        return myCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addingSegue" {
            let myC = segue.destination as! itemModifierVC
            myC.ueberschrift = "Neuer Eintrag?"
            myC.color = UIColor.blue
            myC.thisDelegate = self
            
            
        } else if segue.identifier == "cellsSegue" {
            let myC = segue.destination as! itemModifierVC
            myC.ueberschrift = "Bearbeite Eintrag?"
            if let myIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                myC.itemToBeEdited = myItems[index].items[myIndexPath.row]
            }
            myC.color = UIColor.brown
            myC.thisDelegate = self
        }
    }
    func addingItems(_ controller: itemModifierVC, addingItems newItem: String) {
        navigationController?.popViewController(animated: true)
        print(newItem)
        let first = ItemsData()
        first.names = newItem
        myItems[index].items.append(first)
        tableView.reloadData()
        //delegate.saver()
    }

    func editingItems(_ controller: itemModifierVC, editingItems newItem: ItemsData) {
        navigationController?.popViewController(animated: true)
        //delegate.saver()
        tableView.reloadData()
    }
    
}




