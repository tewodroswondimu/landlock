//
//  LoginViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 12/7/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

struct loginJSONDescription: Decodable {
    let auth: String
    let token: String
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        
        let jsonUrlString: String = "http://165.165.131.67:4000/api/auth/login/"
        let email = "brian@gmail.com"
        let password = "brian"
        let parameterDictionary: [String: String] = ["email": email, "password": password]
        
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
                
                let jsonDescription = try JSONDecoder().decode(loginJSONDescription.self, from: data)
                let authenticationToken = jsonDescription.token
                
                UserDefaults.standard.setValue(authenticationToken, forKey: "user_auth_token")
                
                // perform request
                print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
                self.dismiss(animated: true, completion: nil)
                print(jsonDescription)
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
