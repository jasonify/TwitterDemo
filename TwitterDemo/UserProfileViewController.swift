//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by jason on 11/2/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var user:User?
    
    var tweets = [Tweet]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if user == nil {
            user  = User.currentUser
        }
        
        if let user = user{
            nameLabel.text =  user.name
            usernameLabel.text = user.screenName
            profileImage.setImageWith(user.profileImageUrl!)
        
            TwitterClient.sharedInstance?.timeline(user: user, success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tableView.reloadData()
                }, failure: { (error:Error) in
                    print(error)
            })
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
       
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = Bundle.main.loadNibNamed("SingleTweetTableViewCell", owner: self, options: nil)?.first  as! SingleTweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
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
