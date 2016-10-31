//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by jason on 10/29/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!
        , consumerKey: "xl5FOzSSIsS1k5DWSUwDi0iY2", consumerSecret: "9i4GUWdoHunftmEELd7hE0CEVbMKtSUPcJWq6193RYWFxY55hV")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(sucess: @escaping () ->(), failure: @escaping (Error) -> ()){
        
        loginSuccess = sucess
        loginFailure = failure
            
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as! URL, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("got token")
            let urlstr = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)"
            print(urlstr)
            let url = NSURL(string: urlstr)
            UIApplication.shared.open(url as! URL, options: [:], completionHandler: { (done: Bool) in
                
            })
            //  UIApplication.shared.openURL(url as! URL)
            
            }, failure: { (error: Error?) in
               // print("error: ", error?.localizedDescription )
                self.loginFailure?(error!)
        })
        
        
    }
    
    func handleOpenUrl(_ url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        let twitterClient = TwitterClient.sharedInstance
        
        twitterClient?.deauthorize() // required or bugs..
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken,  success: { (requestToken: BDBOAuth1Credential?) in
            
            
            //twitterClient?.homeTimeline()
            //  twitterClient?.tweet()
            
            
            self.loginSuccess?()
            
            
            //  UIApplication.shared.openURL(url as! URL)
            
            }, failure: { (error: Error?) in
               // print("error: ", error?.localizedDescription )
                self.loginFailure?(error!)
        })
        
    }
    
    func currentAccount(){
        
        
        let pathURL = "1.1/account/verify_credentials.json"
        
        get(pathURL, parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            //print("account", response)
            
            let userDictionary = response as! NSDictionary
            let user = User(userDictionary)
            print("!!!!!!!!!!!!!!!!!!")
            print("name", user.name)
            
            }, failure: { (task:URLSessionDataTask?, error:Error) in
                
        })
    }
    
    func tweet(){
        let url = "/1.1/statuses/update.json?status=Maybe%20he%27ll%20finally%20find%20his%20keys"
        
        post(url, parameters: nil, progress: nil,
             success: { (task:URLSessionDataTask, response:Any?) in
               print("TWEETEEDDDD!!")
                
            }, failure: { (task:URLSessionDataTask?, error:Error) in
                
        })
        
             
    }
    func homeTimeline( success: @escaping ([Tweet]) -> (), failure: @escaping (Error) ->() ){
        let timelineURL = "1.1/statuses/home_timeline.json"
        
        get(timelineURL, parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            let tweetsDictionary = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetsDictionary)
            
            success(tweets)
            
            
            }, failure: { (task:URLSessionDataTask?, error:Error) in
                    failure(error)
        })
        
    }
}


