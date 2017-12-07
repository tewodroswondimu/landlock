//
//  LoginViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 12/7/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        // perform request
        let tokenStore: String = "hello"
        UserDefaults.standard.setValue(tokenStore, forKey: "user_auth_token")
        print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
