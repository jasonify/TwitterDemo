//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by jason on 11/2/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var heroImage: UIImageView!
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user{
            nameLabel.text =  user.name
            usernameLabel.text = user.screenName
            profileImage.setImageWith(user.profileImageUrl!)
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
