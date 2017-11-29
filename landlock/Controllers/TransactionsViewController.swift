//
//  TransactionsViewController.swift
//  landlock
//
//  Created by Tewodros Wondimu on 11/28/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 10
    }
    
    // Definition of each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "Transaction", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Transaction \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "Description \(indexPath.row + 1)"
        return cell
    }
}

