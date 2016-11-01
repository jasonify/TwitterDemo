//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/31/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeTweetViewController: UIViewController {

    var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()

        if tweet != nil {
            tweetButton.title = "Reply"
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tweetButton: UIBarButtonItem!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweettextField: UITextView!
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTweet(_ sender: AnyObject) {
    
        let text = tweettextField.text!
        if let tweet = tweet{
            print("tweet reply...")
            TwitterClient.sharedInstance?.replyTo(tweet:  tweet, replyText: text)
        } else {
            print("fresh tweet")
            TwitterClient.sharedInstance?.tweet(text: text )
        }
        dismiss(animated: true, completion: nil)
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
