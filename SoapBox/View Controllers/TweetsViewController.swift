//
//  TweetsViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet]! = [Tweet]()
    @IBOutlet weak var tweetsTableView: UITableView!
    
    var menuViewController: MenuViewController!
    
    var loadingMoreData: Bool! = false

    func loadTimeline(sinceId: Int?, next: (() -> Void)?) {
        TwitterClient.getInstance().homeTimeline(sinceId: sinceId, success: { (tweets) in
            if sinceId != nil {
                self.tweets = self.tweets + tweets
            }
            else{
                self.tweets = tweets
            }
            self.tweetsTableView.reloadData()
            next?()
            print(tweets)
        }) { (error) in
            if let err = error {
                print(err)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = User.currentUser?.handle! ?? "Timeline"

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refreshControlAction(_:)),
            for: UIControlEvents.valueChanged
        )
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        self.loadTimeline(sinceId: nil, next: nil)
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        tweetsTableView.estimatedRowHeight = 250
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        

        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        print("refreshing")
        self.loadTimeline(sinceId: nil) {
            refreshControl.endRefreshing()
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.getInstance().logout()
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
        if let destination = segue.destination as? TweetViewController {
            if let sender = sender as? TweetTableViewCell {
                print(sender.tweet)
                destination.tweet = sender.tweet
            }
        }
        
        if let destination = segue.destination as? UINavigationController {
            if let profileViewController = destination.topViewController as? ProfileViewController {
                if let sender = sender as? TweetTableViewCell {
                    profileViewController.user = sender.tweet.user
                }
            }
        }

    }
    

}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetTableViewCell
        cell.tweet = self.tweets[indexPath.row]
        cell.delegate = menuViewController
        return cell
        
    }
    

}


extension TweetsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.loadingMoreData {
            let reloadThreshold = self.tweetsTableView.contentSize.height / 2
            
            if scrollView.contentOffset.y > reloadThreshold && scrollView.isDragging {
                self.loadingMoreData = true
                self.loadTimeline(sinceId: self.tweets.last!.id!, next: {
                    () -> Void in
                    self.loadingMoreData = false
                })
            }
            
        }
    }
}
