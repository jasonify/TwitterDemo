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
    
    @IBOutlet weak var statusCountLabel: UILabel!
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
        
            statusCountLabel.text = "\(user.statusCount)"
            TwitterClient.sharedInstance?.timeline(user: user, success: { (tweets: [Tweet]) in
            //TwitterClient.sharedInstance?.mentions(user: user, success: { (tweets: [Tweet]) in
                self.tweets = tweets
                self.tableView.reloadData()
                }, failure: { (error:Error) in
                    print(error)
            })
            
            TwitterClient.sharedInstance!.heroImage(user, success: { (imageUrl: String) in
                
                let url = URL(string: imageUrl)
                if let url = url {
                    self.heroImage.setImageWith(url)
                }
                }, failure: { (error:Error) in
                    
            })
            
            
            profileImage.layer.cornerRadius = 8
            profileImage.layer.masksToBounds = true
            
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
        let cell = Bundle.main.loadNibNamed("TweetTableViewCell", owner: self, options: nil)?.first  as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    
        
        
        if(segue.identifier == "showTweetDetails") {
            
            let navigationController = segue.destination as! UINavigationController
            
            let tweetDetailsVieController = navigationController.topViewController as! TweetDetailViewController
            
            tweetDetailsVieController.tweet  = selectedTweet
        }
        if segue.identifier == "showReplyTweet"{
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.tweet  = selectedTweet
            
        }
        
        if segue.identifier == "showCompose"{            
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.user  = User.currentUser
            
        }
        
        if segue.identifier == "showUserProfile"{
            
            if ( selectedUser?.screenName! == User.currentUser?.screenName!){
                print("SAME USER!")
            } else {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileViewController
            nextViewController.user = selectedUser
            self.present(nextViewController, animated:true, completion:nil)
            }
            
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tweets.count > indexPath.row){
            selectedTweet = tweets[indexPath.row]
            self.performSegue(withIdentifier: "showTweetDetails", sender: self)                    
        }
    }
    
    
    @IBAction func onCancelPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    var selectedTweet: Tweet?
    var selectedUser: User?
}



extension UserProfileViewController: TweetTableViewCellDelegate {
    func replySelected(tweet: Tweet) {
        
        print("ABOUT TO REPLY")
        selectedTweet = tweet
        
        performSegue(withIdentifier: "showReplyTweet", sender: self)
        
        //
    }
    
    
    func userSelected(user: User) {
        selectedUser = user
        performSegue(withIdentifier: "showUserProfile", sender: self)
        
    }
}




