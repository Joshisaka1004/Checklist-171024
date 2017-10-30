//
//  itemModifierVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 26.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

protocol itemModifierDelegate {
    func addingItems(_ controller: itemModifierVC, addingItems newItem: String)
    func editingItems(_ controller: itemModifierVC, editingItems newItem: ItemsData)
}

class itemModifierVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    var thisDelegate: itemModifierDelegate!
    var ueberschrift: String!
    var color: UIColor = UIColor.yellow
    var itemToBeEdited: ItemsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
        view.backgroundColor = color
        if ueberschrift != nil {
            title = ueberschrift
        }
        if let itemToBeEdited = itemToBeEdited {
            myTextField.text = itemToBeEdited.names
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
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if let itemToBeEdited = itemToBeEdited {
            itemToBeEdited.names = myTextField.text!
            thisDelegate.editingItems(self, editingItems: itemToBeEdited)
        } else {
            let newItem = myTextField.text!
            thisDelegate.addingItems(self, addingItems: newItem)
        }
    }
}
