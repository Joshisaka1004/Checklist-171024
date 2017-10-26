//
//  categoryModifierVC.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 25.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class categoryModifierVC: UITableViewController {

    var delegate: categoriesVC!
    var myTitle = ""
    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = myTitle
    }

    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if myTextField.text != "" {
            delegate.feedMyTable(newCategory: myTextField.text!)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
        delegate.save()
    }
}
