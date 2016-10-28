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
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: nil, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("got token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize")
            UIApplication.shared.openURL(url as! URL)
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
