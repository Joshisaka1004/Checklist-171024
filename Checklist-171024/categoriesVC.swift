//
//  ViewController.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoriesVC: UITableViewController, categoryModifierDelegate, UINavigationControllerDelegate {

    var myCounter = -1
    var categories = [CategoriesData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        myCounter = UserDefaults.standard.object(forKey: "myIndex") as? Int ?? -1
        print("Hallo", myCounter)
        load() // Es wird der gespeicherte Array categories geladen
        if categories.isEmpty { // falls dieser Array jedoch leer ist, dann
            feedMyTable()   // wird die Funktion feedMyTabel aufgerufen, aber nur dann
        } // da wir nichts weiter angeben (), wird der leere default-String genutzt
        print(getmyPath())
    }
    
    func feedMyTable(newCategory: String = "") {
        
// Wenn die Funktion von viewDidLoad() gecallt wird, dann ist newCategory leer
// und es wir in der obersten Tabellenzeile ein Hinweis gezeigt
        
        let category1 = CategoriesData()
        if newCategory == "" {
            category1.categoryNames = "NOCH KEINE KATEGORIE!"
        } 
        
        categories.append(category1)
        if categories.count > 1 && categories[0].categoryNames == "NOCH KEINE KATEGORIE!" {
            categories.remove(at: 0)
        }
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
        //saver()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self {
            myCounter = -1
            UserDefaults.standard.set(myCounter, forKey: "myIndex")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = self
        if myCounter != -1 {
            performSegue(withIdentifier: "cellsSegue", sender: myCounter)
        } 
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let myIndexPath = IndexPath(row: indexPath.row, section: 0)
        categories.remove(at: indexPath.row)
        tableView.deleteRows(at: [myIndexPath], with: .automatic)
        if categories.isEmpty {
            feedMyTable()
        }
        //saver()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.text = categories[indexPath.row].categoryNames
        return myCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myRow = indexPath.row
        UserDefaults.standard.set(myRow, forKey: "myIndex")
        performSegue(withIdentifier: "cellsSegue", sender: myRow)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellsSegue" {
            let myController = segue.destination as! categoryItemsVC
            //if let myIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            let myIndex = sender as! Int
            myController.myItems = categories
            myController.index = myIndex
            myController.myTitle = categories[myIndex].categoryNames
            myController.delegate = self
            //UserDefaults.standard.set(myIndex, forKey: "myIndex")
            //}
        } else if segue.identifier == "accessorySegue" {
            let myController = segue.destination as! categoryModifierVC
            myController.color = UIColor.green
            myController.neuerText = "Kategorie bearbeiten!"
            myController.myTitle = "Bearbeite Kategorie"
            if let myIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                myController.itemToBeEdited = categories[myIndexPath.row]
            }
            
            myController.delegate = self
        } else if segue.identifier == "addSegue" {
            let myController = segue.destination as! categoryModifierVC
            myController.color = UIColor.yellow
            myController.neuerText = "Neue Kategorie, bitte!"
            myController.myTitle = "Neue Kategorie"
            myController.delegate = self
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
            print("Saving Error!")
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
            print("Loading Error!")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //feedMyTable(myParam: nil)
    }
    
    func editCategory(_ controller: categoryModifierVC, editedItem: CategoriesData) {
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
        //saver()
    }
    func addCategory(_ controller: categoryModifierVC, addedItem: CategoriesData) {
        navigationController?.popViewController(animated: true)
        categories.append(addedItem)
        if categories[0].categoryNames == "NOCH KEINE KATEGORIE!" {
            categories.remove(at: 0)
        }
        tableView.reloadData()
        //saver()
    }
}

