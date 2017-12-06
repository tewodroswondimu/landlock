//
//  PerformNewTransactionViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/30/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class PerformNewTransactionViewController: UIViewController {
    
    let transactionType = "Transfer"
    let property = "001-A"
    let amount = "1"
    
    @IBOutlet weak var transactionTypeButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var propertyTextField: UITextField!
    @IBAction func onTransactionButtonPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)

        // remove the border for the text field
        propertyTextField.borderStyle = .none
        amountTextField.borderStyle = .none
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submitTransaction(_ sender: Any) {
        self.createTransaction(transactionType: "Transfer", propertyID: "001-A", newPropertySize: "2")
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTransaction(transactionType: String, propertyID: String,  newPropertySize: String) {
        
        let jsonUrlString = "http://165.165.131.67:4000/land/transfer"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let parameterDictionary = ["granteeId" : amountTextField.text!, "landId": propertyTextField.text!, "doneBy": "teddy@gmail.com"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if there is an error
            // Check if the response status is 200 OK
            
            // Get a non-optional data string
            guard let data = data else { return }
            
            do {
                let jsonDescription = try JSONDecoder().decode(personJSONDescription.self, from: data)
                print(jsonDescription)
                /*
                for person in jsonDescription.results {
                    self.person = person
                    DispatchQueue.main.async {
                        //self.profilePictureName.text = person.firstName! + " " + person.lastName!
                        self.profileAccountDetails.text = person.email
                    }
                }
                */
                
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
            }.resume()
    }
    
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChooseTransactionType"
        {
            if let destinationVC = segue.destinationViewController as? TransactionTypeViewController {
                destinationVC.currentChoice = self.transactionTypeButton.titleLabel?.text
            }
        }
    }
    */
}
