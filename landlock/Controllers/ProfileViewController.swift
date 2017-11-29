//
//  ProfileViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileRegistrationStatus: UIImageView!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    @IBOutlet weak var profilePictureName: UILabel!
    @IBOutlet weak var profileAccountDetails: UILabel!
    
    @IBOutlet weak var userSettingsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the profile picture to a circle and add borders to it
        profilePictureView.layer.cornerRadius = 20
        profilePictureView.clipsToBounds = true
        
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 2.5
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


