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

    @IBAction func composePressed(_ sender: AnyObject) {
        
        
        performSegue(withIdentifier: "showCompose", sender: self)

    
    }
    
    
    var tweets = [Tweet]()
    let refreshControl = UIRefreshControl()

    var selectedTweet: Tweet?
    var selectedUser: User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refresh()

        

        refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height/2, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refresh()
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.refresh()
    }

    func refresh(){
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()

            }, failure: { (error:Error) in
                self.refreshControl.endRefreshing()

                print(error.localizedDescription)
        })
        
        
    }
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "showTweetDetails") {

            let navigationController = segue.destination as! UINavigationController
            
            let tweetDetailsVieController = navigationController.topViewController as! TweetDetailViewController
 
            tweetDetailsVieController.tweet  = selectedTweet
        }
        if segue.identifier == "showReplyTweet"{
        
        
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.tweet  = selectedTweet
            
        }
        
        if segue.identifier == "showCompose"{
            
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! ComposeTweetViewController
            composeView.user  = User.currentUser
            
        }
        
        if segue.identifier == "showUserProfile"{
            
            /*
          //  let navigationController = segue.destination as! UINavigationController
            self.view
            let viewTo = navigationController.topViewController as! UserProfileViewController
            viewTo.user  = User.currentUser
            */
            
            /*
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileViewController
            nextViewController.user = selectedUser
            self.present(nextViewController, animated:true, completion:nil)
            */
            
            
            let navigationController = segue.destination as! UINavigationController
            let composeView = navigationController.topViewController as! UserProfileViewController
            composeView.user  = selectedUser
            
            
            
            
        }
        
        
        /*
 
 
         
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileViewController
         nextViewController.user = selectedUser
         self.present(nextViewController, animated:true, completion:nil)
         
         
         print("hello")
         
         
        */
        

    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?


}
extension TweetsViewController: UIScrollViewDelegate {

    
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading && tweets.count > 0) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                self.loadingMoreView!.isHidden = false

                // Update position of loadingMoreView, and start loading indicator
                
//                let frame = CGRect(origin: CGPoint(x: 0,y :tableView.contentSize.height), size: CGSize(width:  tableView.bounds.size.widt, height: 100))

                let frame = self.CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()

                
                
                // ... Code to load more results ...
                
                TwitterClient.sharedInstance?.homeTimelineOlder(tweets, success: { (tweets:[Tweet]) in
                    
                    self.isMoreDataLoading = false
                    self.loadingMoreView!.isHidden = true


                    self.tweets = tweets
                    self.tableView.reloadData()
            
                    self.refreshControl.endRefreshing()

                    self.loadingMoreView!.stopAnimating()

                    
                    }, failure: { (error:Error) in
                        self.refreshControl.endRefreshing()
                        self.isMoreDataLoading = false
                        self.loadingMoreView!.stopAnimating()
                        self.loadingMoreView!.isHidden = true

                        print(error.localizedDescription)
                })
            }
        }
    }

}


extension TweetsViewController: TweetTableViewCellDelegate {
    func replySelected(tweet: Tweet) {
        
        print("ABOUT TO REPLY")
        selectedTweet = tweet
        
        performSegue(withIdentifier: "showReplyTweet", sender: self)
        
      //
    }
    
    
    func userSelected(user: User) {
        selectedUser = user
        performSegue(withIdentifier: "showUserProfile", sender: self)

    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    // implementation of protocol requirements goes here
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tweets.count > indexPath.row){
            print("selected: ", tweets[indexPath.row].text )
            selectedTweet = tweets[indexPath.row]
            
            self.performSegue(withIdentifier: "showTweetDetails", sender: self)
         
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count", tweets.count)
        
        return tweets.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TweetTableViewCell", owner: self, options: nil)?.first  as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
    
    
    
}

