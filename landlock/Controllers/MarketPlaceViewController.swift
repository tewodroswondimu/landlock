//
//  marketPlaceViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/29/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class MarketPlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var marketPlaceTableView: UITableView!
    
    // Fake data to load into properties
    let propertyNames = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.value(forKey: "user_auth_token") as! String == "" {
            // Load login - LoginSegue
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            print("You're logged in")
        }
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
        return 10
    }
    
    // Definition of each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketPlaceTableView.dequeueReusableCell(withIdentifier: "MarketPlace", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Property \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "Description \(indexPath.row + 1)"
        return cell
    }
}

