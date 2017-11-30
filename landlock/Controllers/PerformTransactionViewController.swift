//
//  PerformTransactionViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/30/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class PerformTransactionViewController: UIViewController {
    
    
    @IBOutlet weak var transactionTypeButton: NSLayoutConstraint!
    @IBOutlet weak var propertyButton: NSLayoutConstraint!
    @IBOutlet weak var amountTextfield: UITextField!
    
    @IBAction func onTransactionTypeButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onPropertyButtonPressed(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove the border for the text field
        amountTextfield.borderStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

