//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by jason on 10/30/16.
//  Copyright © 2016 jasonify. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!

    var tweets = [Tweet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
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

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    // implementation of protocol requirements goes here
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count", tweets.count)
        return tweets.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
    }
    
    
    
    
}

