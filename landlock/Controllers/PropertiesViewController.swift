//
//  PropertiesViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

struct JSONDescription: Decodable {
    let type: String?
    let results: [Property]
}

struct Property: Decodable {
    let landId: String?
    let landSize: Double?
    let landStatus: String?
    let parent: String?
    let subdivided: Bool?
    let owner: String?
}

class PropertiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var propertiesTableView: UITableView!
    var selectedProperty = ""
    var token = ""
    
    // Fake data to load into properties
    var properties = [Property]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        properties = [Property]()
        
        if UserDefaults.standard.value(forKey: "user_auth_token") != nil {
            token = UserDefaults.standard.value(forKey: "user_auth_token") as! String
        }
        if token == "" {
            // Load login - LoginSegue
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            print("You're logged in")
            print("The token is: \(token)")
            self.updateProperties()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateProperties() {
        
        let jsonUrlString = "http://165.165.131.67:4000/land/my-property"
        
        let currentUser = "roger@gmail.com"
        let parameterDictionary = ["ownerId": currentUser]
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(token)", forHTTPHeaderField: "X-Access-Token")
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
                let myJSON = try  JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                print(myJSON)
                let jsonDescription = try JSONDecoder().decode(JSONDescription.self, from: data)
                
                // print(jsonDescription.type, "Ha ha, it works",  jsonDescription.results)
                
                if (jsonDescription.type == "Land") {
                    for property in jsonDescription.results {
                        self.properties.append(property)
                        DispatchQueue.main.async {
                            self.propertiesTableView?.reloadData()
                        }
                    }
                }
                
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
            }.resume()
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
        return self.properties.count
    }
    
    // Definition of each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = propertiesTableView.dequeueReusableCell(withIdentifier: "Property", for: indexPath) as UITableViewCell
        let property = self.properties[indexPath.row]
        cell.textLabel?.text = property.landId
        cell.detailTextLabel?.text = property.owner
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let property = self.properties[indexPath.row]
        self.selectedProperty = property.landId!
    }
    
    // Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let path = self.propertiesTableView.indexPathForSelectedRow {
            let property = self.properties[path.row]
            self.selectedProperty = property.landId!
            
            if segue.identifier == "Properties"
            {
                if let destinationVC = segue.destination as? PropertyDetailsViewController {
                    destinationVC.propertyID = self.selectedProperty
                    destinationVC.senderVC = self
                }
            }
        }
    }
}

