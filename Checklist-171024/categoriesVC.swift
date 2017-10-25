//
//  ViewController.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoriesVC: UITableViewController {

    var categories = [CategoriesData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        print(getmyPath())
        navigationController?.navigationBar.prefersLargeTitles = true
        if categories.isEmpty {
            feedMyTable()
        }
    }
    
    func feedMyTable() {

        let category1 = CategoriesData()
        category1.categoryNames = "Puzzle Families"
        let category2 = CategoriesData()
        category2.categoryNames = "Conceptis Tasks"
        
        categories.append(category1)
        categories.append(category2)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = categories[indexPath.row].categoryNames
        return myCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellsSegue" {
            let myController = segue.destination as! categoryItemsVC
            if let myIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                myController.myItems = categories
                myController.index = myIndexPath.row
                myController.delegate = self
            }
        }
    }
    
    func getmyPath() -> URL {
        let myManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = myManager[0]
        let myPath = docURL.appendingPathComponent("myTest.plist")
        return myPath
    }
    func save() {
        let myPath = getmyPath()
        let myEncoder = PropertyListEncoder()
        do {
            let myTemp1 = try myEncoder.encode(categories)
            try myTemp1.write(to: myPath)
        }
        catch {
            print("Error!")
        }
    }
    func load() {
        let myDecoder = PropertyListDecoder()
        let myPath = getmyPath()
        do {
            let myData = try Data(contentsOf: myPath)
            categories = try myDecoder.decode([CategoriesData].self, from: myData)
        }
        catch {
            print("Error!")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //feedMyTable(myParam: nil)
    }
}

