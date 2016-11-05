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
    @objc optional func userSelected(user: User)
    
}


class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetImage: UIImageView!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
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
            nameLabel.text = tweet.user?.name
            usernameLabel.text = tweet.user?.screenName
            if(tweet.favorited) {
                favoriteImage.image = #imageLiteral(resourceName: "favorited")
            } else {
                favoriteImage.image = #imageLiteral(resourceName: "favorite")
            }
            
        }
        
    }
    
    
    func userProfileImagePressed (gesture: UITapGestureRecognizer){
        delegate?.userSelected?(user: tweet!.user!)
        
    }
    
    
    func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favorite(tweet: tweet)
    }
    func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(tweet: tweet)
    }
    
    
    func onReply(_ sender: AnyObject) {
        print("REPLYING!")
        delegate?.replySelected?(tweet: tweet!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //////////////////////
        let tap = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.userProfileImagePressed(gesture:)))
        
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
        
        
        // Initialization code
        profileImage.layer.cornerRadius = 8
        profileImage.layer.masksToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
