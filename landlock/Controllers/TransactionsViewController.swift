//
//  TransactionsViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

struct transactionJSONDescription: Decodable {
    let type: String
    let results: [Transaction]
}

struct Transaction: Decodable {
    let transactionType: String?
    let transactionId: String?
    let timestamp: String?
    let doneBy: String?
}

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var transactionTableView: UITableView!
    // Fake data to load into transaction
    var transactions = [Transaction]()
    
    override func viewWillAppear(_ animated: Bool) {
        transactions = [Transaction]()
        self.updateTransactions()
        
        if UserDefaults.standard.value(forKey: "user_auth_token") as! String == "" {
            // Load login - LoginSegue
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            print("You're logged in")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTransactions();
        // For the extended navigation bar effect to work, a few changes
        // must be made to the actual navigation bar.  Some of these changes could
        // be applied in the storyboard but are made in code for clarity.
        
        // Translucency of the navigation bar is disabled so that it matches with
        // the non-translucent background of the extension view.
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "TransparentPixel"), for: .default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds the line underneath the imageview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
    }
    
    // Set the number of sections available in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Set the number of rows in the sections available in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    // Definition of each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "Transaction", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Transaction \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "Description \(indexPath.row + 1)"
        return cell
    }
    
    
    func updateTransactions() {
        
        let jsonUrlString = "http://165.165.131.67:4000/transactions/"
        
        let currentUser = "teddy@gmail.com"
        let parameterDictionary = ["doneBy": currentUser]
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check if there is an error
            // Check if the response status is 200 OK
            
            // Get a non-optional data string
            guard let data = data else { return }
            
            do {
                let jsonDescription = try JSONDecoder().decode(transactionJSONDescription.self, from: data)
                // print(jsonDescription.type, "Ha ha, it works",  jsonDescription.results)
                
                if (jsonDescription.type == "Historian") {
                    for transaction in jsonDescription.results {
                        self.transactions.append(transaction)
                        DispatchQueue.main.async {
                            self.transactionTableView?.reloadData()
                        }
                    }
                }
                
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
            }.resume()
    }
}

