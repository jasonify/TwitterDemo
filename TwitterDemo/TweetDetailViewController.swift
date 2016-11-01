//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/31/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var tweetTextlabel: UILabel!
   
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        print("tweet", tweet?.text)
        tweetTextlabel.text = tweet?.text
        // Do any additional setup after loading the view.
    }

    @IBAction func onReplyPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "showReplyTweet", sender: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(_ sender: AnyObject) {
         dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showReplyTweet"{
            
            
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.tweet  = tweet
            
        }
        
    }
    
    
    

}