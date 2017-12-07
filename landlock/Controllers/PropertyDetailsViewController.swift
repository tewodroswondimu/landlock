//
//  PropertyDetailsViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/29/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class PropertyDetailsViewController: UIViewController {
    var propertyID: String = ""
    var senderVC: PropertiesViewController? 
    
    @IBOutlet weak var propertyTextField: UITextField!
    @IBOutlet weak var propertyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.propertyLabel.text = propertyID
        self.propertyTextField.text = propertyID
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.propertyLabel.text = propertyID
        self.propertyTextField.text = propertyID
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
