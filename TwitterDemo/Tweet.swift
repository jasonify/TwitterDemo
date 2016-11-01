//
//  Tweet.swift
//  TwitterDemo
//
//  Created by jason on 10/28/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    var id: String?
    var favorited: Bool = false
    var prettyTimeStamp: String?
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        // print(dictionary)
        print(dictionary["favorite_count"])
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        print(favoritesCount)
        id = dictionary["id_str"] as? String
        
        favorited = (dictionary["favorited"] as? Bool) ?? false

        
        
        
        
        user = User(dictionary["user"] as! NSDictionary)
        
      
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
            print(timestamp)
            prettyTimeStamp  = timestamp!.timeAgo
            print("prettyTimestamp", prettyTimeStamp)
            
        }
    }

    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
    }
}
