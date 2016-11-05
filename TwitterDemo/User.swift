//
//  User.swift
//  TwitterDemo
//
//  Created by jason on 10/28/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    var profileImageUrl: URL?

    var screenName: String?
    var statusCount: Int = 0
    var dictionary: NSDictionary?
    
    init(_ dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }            
        screenName = dictionary["screen_name"] as? String
        
        statusCount = (dictionary["statuses_count"] as? Int) ?? 0
        
        let profileImageUrlString = dictionary["profile_image_url_https"] as? String
        print(profileImageUrlString)
        if profileImageUrlString != nil {
            profileImageUrl = URL(string: profileImageUrlString!)
        } else {
            profileImageUrl = nil
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    static let userDidLogoutNotification = Notification.Name("UserDidLogout")

    class var currentUser: User?{
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                print("userData", userData)
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(
                        with: userData as Data, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary)
                    
                }
            }
            return _currentUser
        }
        
        set(user){
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                print("user dict", user.dictionary)
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey:  "currentUserData")
            } else {
                print("setting nil!!!")
                defaults.removeObject(forKey: "currentUserData")
                //defaults.set(nil, forKey:  "currentUserData")
            }
          //  //defaults.set(user, forKey:  "currentUserData")
            defaults.synchronize()
        }
    }
    
}
