//
//  ProfileViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

struct personJSONDescription: Decodable {
    let results: [Person]
}

struct Person: Decodable {
    var email: String?
    var firstName: String?
    var lastName: String?
    //var middleName: String?
    //var address: Address?
    //var accountBalance: Double?
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileRegistrationStatus: UIImageView!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    @IBOutlet weak var profilePictureName: UILabel!
    @IBOutlet weak var profileAccountDetails: UILabel!
    
    @IBOutlet weak var userSettingsTableView: UITableView!
    
    var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the profile picture to a circle and add borders to it
        profilePictureView.layer.cornerRadius = 20
        profilePictureView.clipsToBounds = true
        
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 2.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.person = Person()
        self.updatePerson()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePerson() {
        
        let jsonUrlString = "http://165.165.131.67:4000/person/my-details"
        guard let url = URL(string: jsonUrlString) else { return }
        
        let parameterDictionary = ["userEmail" : "roger@gmail.com"]
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
                
                for person in jsonDescription.results {
                    self.person = person
                    DispatchQueue.main.async {
                        //self.profilePictureName.text = person.firstName! + " " + person.lastName!
                        self.profileAccountDetails.text = person.email
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
    
    // Set the title of the different sections in the table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    // Set the number of rows in the sections available in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // Definition of each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userSettingsTableView.dequeueReusableCell(withIdentifier: "Setting", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Transaction \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "Description \(indexPath.row + 1)"
        return cell
    }
    
}


