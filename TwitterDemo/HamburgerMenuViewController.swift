//
//  HamburgerMenuViewController.swift
//  TwitterDemo
//
//  Created by jason on 11/5/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController! {
        
        didSet {
            
            hamburgerViewController.contentViewController = viewControllers[0]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        let storybaord = UIStoryboard(name: "Main", bundle: nil)
        
        let s1 = storybaord.instantiateViewController(withIdentifier: "TweetsNavigationController")
        let s2 = storybaord.instantiateViewController(withIdentifier: "UserProfile")
        // mentions
        
        viewControllers.append(s1)
        viewControllers.append(s2)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewControllers.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        cell.nameLabel.text = "HELLO"
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
