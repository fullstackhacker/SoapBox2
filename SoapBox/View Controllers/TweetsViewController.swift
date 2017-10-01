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

    func loadTimeline(next: (() -> Void)?) {
        TwitterClient.getInstance().homeTimeline(success: { (tweets) in
            self.tweets = tweets
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
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refreshControlAction(_:)),
            for: UIControlEvents.valueChanged
        )
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        self.loadTimeline(next: nil)
        
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        tweetsTableView.estimatedRowHeight = 250
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        

        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        print("refreshing")
        self.loadTimeline() {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetTableViewCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
        
    }
    

}
