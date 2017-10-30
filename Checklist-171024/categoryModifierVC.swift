//
//  categoryModifierVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 25.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

protocol categoryModifierDelegate {
    func addCategory(_ controller: categoryModifierVC, addedItem: CategoriesData)
    func editCategory(_ controller: categoryModifierVC, editedItem: CategoriesData)
}

class categoryModifierVC: UITableViewController, UITextFieldDelegate {

    var delegate: categoryModifierDelegate!
    var myTitle = ""
    var color: UIColor!
    var neuerText: String!
    var itemToBeEdited: CategoriesData?
    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
        title = myTitle
        view.backgroundColor = color
        if let itemToBeEdited = itemToBeEdited, itemToBeEdited.categoryNames != "NOCH KEINE KATEGORIE!" {
                myTextField.text = itemToBeEdited.categoryNames
        }
        let myTap = UITapGestureRecognizer(target: self, action: #selector(tapConfigure))
        view.addGestureRecognizer(myTap)
    }

    @objc func tapConfigure(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let myText = neuerText
        if section == 0 {
            if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myCell") {
                cell.textLabel!.text = myText
            }
        }
        return myText
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if let itemToBeEdited = itemToBeEdited, myTextField.text != "" {
            itemToBeEdited.categoryNames = myTextField.text!
            delegate.editCategory(self, editedItem: itemToBeEdited)
        } else {
            let newItem = CategoriesData()
            newItem.categoryNames = myTextField.text!
            delegate.addCategory(self, addedItem: newItem)
        }
    }
}
