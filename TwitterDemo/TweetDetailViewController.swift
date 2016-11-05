//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/31/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    
    @IBOutlet weak var tweetTextlabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var tweet: Tweet?
    
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
       // print("tweet", tweet?.text)
        
        if let tweet = tweet {
            nameLabel.text = tweet.user!.name!
            usernameLabel.text = tweet.user!.screenName!
            
            print("name", tweet.user!.name!)
            
            profilePicture.setImageWith((tweet.user?.profileImageUrl)!)
            
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoritesCount)"
            tweetTextlabel.text = tweet.text
                        
            rerenderFavorite()
        }
        
        //////////////////////
        let tap = UITapGestureRecognizer(target: self, action: #selector(TweetDetailViewController.reteweetTapped(gesture:)))
        
        retweetImage.addGestureRecognizer(tap)
        retweetImage.isUserInteractionEnabled = true
        ///
        
        //////////////////////
        let tapReply = UITapGestureRecognizer(target: self, action: #selector(TweetDetailViewController.replyTapped(gesture:)))
        
        replyImage.addGestureRecognizer(tapReply)
        replyImage.isUserInteractionEnabled = true
        ///
        
        //////////////////////
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(TweetDetailViewController.favoriteTapped(gesture:)))
        
        
        favoriteImage.addGestureRecognizer(tapFavorite)
        // favoriteImage.transform.rotated(by: )
        favoriteImage.isUserInteractionEnabled = true
        ///
        
        
        
        /////////////
        
        // Do any additional setup after loading the view.
    }

    
    
    func favoriteTapped(gesture: UITapGestureRecognizer)
    {
        TwitterClient.sharedInstance?.favorite(tweet: tweet!)
       // dismiss(animated: true, completion: nil)
        favoriteImage.image = #imageLiteral(resourceName: "favorited")
       // rerenderFavorite()
        
        
    }
    func rerenderFavorite(){
        if(tweet!.favorited) {
            favoriteImage.image = #imageLiteral(resourceName: "favorited")
        } else {
            favoriteImage.image = #imageLiteral(resourceName: "favorite")
        }
        
    }
    
    
    func reteweetTapped(gesture: UITapGestureRecognizer)
    {
        TwitterClient.sharedInstance?.retweet(tweet: tweet!)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func replyTapped(gesture: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "showReplyTweet", sender: self)
    }
    
    
    
    @IBAction func onReplyPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "showReplyTweet", sender: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(_ sender: AnyObject) {
         dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showReplyTweet"{
            
            
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.tweet  = tweet
            
        }
        
    }
    
    
    

}
