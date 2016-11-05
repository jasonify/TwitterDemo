//
//  SingleTweetTableViewCell.swift
//  TwitterDemo
//
//  Created by jason on 11/2/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class SingleTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            print("Setting tweet")
            
           tweetLabel.text = tweet.text
            if tweet.user?.profileImageUrl != nil {
                profileImage.setImageWith(tweet.user!.profileImageUrl!)
            }
            print("time=", tweet.prettyTimeStamp!)
            //timestampLabel.text = tweet.prettyTimeStamp
            nameLabel.text = tweet.user?.name
           // usernameLabel.text = tweet.user?.screenName
            if(tweet.favorited) {
             //   favoriteImage.image = #imageLiteral(resourceName: "favorited")
            } else {
              //  favoriteImage.image = #imageLiteral(resourceName: "favorite")
            }
            
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
