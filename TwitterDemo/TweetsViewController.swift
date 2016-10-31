//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/30/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
            for tweet in tweets{
                
                print("tweets", tweet.text)
            }
            }, failure: { (error:Error) in
                print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
