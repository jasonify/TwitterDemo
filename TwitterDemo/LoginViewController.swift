//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/26/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!
            , consumerKey: "xl5FOzSSIsS1k5DWSUwDi0iY2", consumerSecret: "9i4GUWdoHunftmEELd7hE0CEVbMKtSUPcJWq6193RYWFxY55hV")
        
        twitterClient?.deauthorize() // required or bugs..
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as! URL, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("got token")
            let urlstr = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)"
            print(urlstr)
            let url = NSURL(string: urlstr)
            UIApplication.shared.open(url as! URL, options: [:], completionHandler: { (done: Bool) in
                
           })
            //  UIApplication.shared.openURL(url as! URL)
            
            }, failure: { (error: Error?) in
                print("error: ", error?.localizedDescription )
        })
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
