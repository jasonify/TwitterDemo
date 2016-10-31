//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by jason on 10/31/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import AFNetworking


@objc protocol  TweetTableViewCellDelegate  {
    @objc optional func replySelected(tweet: Tweet)
}


class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var tweetTextlabel: UILabel!
    
    weak var delegate: TweetTableViewCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            print("Setting tweet")
            
            tweetTextlabel.text = tweet.text
            if tweet.user?.profileImageUrl != nil {
            profileImage.setImageWith(tweet.user!.profileImageUrl!)
            }
            print("time=", tweet.prettyTimeStamp!)
            timestampLabel.text = tweet.prettyTimeStamp
        }
        
    }
    
    
    

    
    func tappedMe(gesture: UITapGestureRecognizer)
    {
        
   
        print("TAPPED IMAGE!!")
    }
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favorite(tweet: tweet)
    }
    @IBAction func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(tweet: tweet)
    }
    
    
    @IBAction func onReply(_ sender: AnyObject) {
        print("REPLYING!")
       
        
        delegate?.replySelected?(tweet: tweet!)
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var tap = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.tappedMe(gesture:)))
        
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
        
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
