//
//  PerformNewTransactionViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/30/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

struct landJSONDescription: Decodable {
    let results: [SubdividedLand]
    let type: String
}

struct SubdividedLand: Decodable {
    var landId1: String?
    var landId2: String?
}

class PerformNewTransactionViewController: UIViewController {
    
    var transactionType = "Subdivide"
    let property = "001-A"
    let amount = "1"
    
    @IBOutlet weak var transactionTypeButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var transactionTypeLabel: NSLayoutConstraint!
    @IBOutlet weak var propertyTextField: UITextField!
    
    @IBOutlet weak var transferToLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionTypeButton.contentHorizontalAlignment = .center
        transactionTypeButton.titleLabel?.text = transactionType
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)

        // remove the border for the text field
        propertyTextField.borderStyle = .none
        propertyTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        amountTextField.borderStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("the new transaction type is: \(transactionType)")
        if transactionType == "Transfer" {
            self.transferToLabel.text = "Transfer to"
            propertyTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        } else if transactionType == "Subdivide" {
            self.transferToLabel.text = "New Land Size"
            
            propertyTextField.attributedPlaceholder = NSAttributedString(string: "Land Size", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        transactionTypeButton.titleLabel?.text = transactionType
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submitTransaction(_ sender: Any) {
        self.createTransaction(transactionType: transactionType, propertyID: propertyTextField.text!, newPropertySize: amountTextField.text!)
        
        let alert = UIAlertController(title: "Transaction Completed", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")}}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTransaction(transactionType: String, propertyID: String,  newPropertySize: String) {
        var jsonUrlString: String = "http://165.165.131.67:4000/land/"
        let currentUser = "roger@gmail.com"
        var parameterDictionary: [String: String] = ["": ""]
        if transactionType == "Transfer" {
            jsonUrlString = jsonUrlString + "transfer-request"
            parameterDictionary = ["granteeId" : amountTextField.text!, "landId": propertyTextField.text!, "doneBy": currentUser]
        } else if transactionType == "Subdivide" {
            jsonUrlString = jsonUrlString + "subdivide-request"
            parameterDictionary = ["originalLandId" :  propertyTextField.text!, "newLandSize": amountTextField.text!, "doneBy": currentUser]
        }
        
        guard let url = URL(string: jsonUrlString) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                
                let myJSON = try  JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                print(myJSON)
                
                let jsonDescription = try JSONDecoder().decode(landJSONDescription.self, from: data)
                
                print(jsonDescription)
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseTransactionType"
        {
            if let destinationVC = segue.destination as? TransactionTypeViewController {
                if let currentLabel = self.transactionTypeButton.titleLabel?.text {
                    destinationVC.currentChoice = currentLabel
                    destinationVC.senderVC = self
                }
            }
        }
    }
}
