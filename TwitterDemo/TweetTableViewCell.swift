//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by jason on 10/31/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetTextlabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            print("Setting tweet")
            
            tweetTextlabel.text = tweet.text
          //  profileImage.setImageWith(URL()
            if tweet.user?.profileImageUrl != nil {
            profileImage.setImageWith(tweet.user!.profileImageUrl!)
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
