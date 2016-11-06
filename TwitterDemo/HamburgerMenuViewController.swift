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
    var viewControllers: [(name: String, view:UIViewController)] = []
    
    
    
    var user:User?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var hamburgerViewController: HamburgerViewController! {
        
        didSet {
            
            hamburgerViewController.contentViewController = viewControllers[0].view
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        let storybaord = UIStoryboard(name: "Main", bundle: nil)
        
        let s1 = storybaord.instantiateViewController(withIdentifier: "TweetsNavigationController")
        let s2 = storybaord.instantiateViewController(withIdentifier: "UserProfile")
        
          let s3 = storybaord.instantiateViewController(withIdentifier: "MentionsUIViewController")
        // mentions
        
        viewControllers.append((name: "Home", view: s1))
        viewControllers.append((name: "Profile", view: s2))
        viewControllers.append((name: "Mentions", view: s3))

        
        
        
        
        profileImage.layer.cornerRadius = 8
        profileImage.layer.masksToBounds = true
        
        
        
        
        if user == nil {
            user  = User.currentUser
        }
        
        if let user = user{
            nameLabel.text =  user.name
            usernameLabel.text = user.screenName
            profileImage.setImageWith(user.profileImageUrl!)
            
         
            
            
            profileImage.layer.cornerRadius = 8
            profileImage.layer.masksToBounds = true
            
        }
        
        

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
        
        cell.nameLabel.text = viewControllers[indexPath.row].name
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row].view
        
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
