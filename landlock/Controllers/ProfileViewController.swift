//
//  ProfileViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileRegistrationStatus: UIImageView!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    @IBOutlet weak var profilePictureName: UILabel!
    @IBOutlet weak var profileAccountDetails: UILabel!
    
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
    
    
}


