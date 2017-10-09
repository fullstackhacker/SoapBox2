//
//  ProfileViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/6/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileHeaderImageView: UIImageView!
    @IBOutlet weak var userProfileTableView: UITableView!
    
    var user: User?
    var tweets: [Tweet]! = []
    var loadingMoreData: Bool! = false
    
    func loadUser(sinceId: Int?, next: (()-> Void)?) {
        if let user = self.user ?? User.currentUser {
            self.user = user
            if let profileBannerUrl = user.profileBannerUrl {
                profileHeaderImageView.setImageWith(profileBannerUrl)
            }
            self.title = user.handle!
            self.loadTimeline(sinceId: sinceId, next: next)
            userProfileTableView.reloadData()
        }
    }
    
    func loadTimeline(sinceId: Int?, next: (() -> Void)?) {
        TwitterClient.getInstance().userTimeline(sinceId: sinceId, handle: user!.handle! ,success: { (tweets) in
            if sinceId != nil {
                self.tweets = self.tweets + tweets
            }
            else{
                self.tweets = tweets
            }
            self.userProfileTableView.reloadData()
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
        self.loadUser(sinceId: nil, next: nil)
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        
        self.loadTimeline(sinceId: nil, next: nil)
        
        userProfileTableView.estimatedRowHeight = 250
        userProfileTableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadUser(sinceId: nil, next: nil)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        print("refreshing")
        self.loadTimeline(sinceId: nil) {
            refreshControl.endRefreshing()
        }
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return self.tweets.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserProfileTableViewCell
            cell.user = user
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetTableViewCell
            cell.tweet = tweets[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}


extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.loadingMoreData {
            let reloadThreshold = self.userProfileTableView.contentSize.height / 2
            
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
