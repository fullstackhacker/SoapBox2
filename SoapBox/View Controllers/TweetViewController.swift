//
//  TweetViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/1/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

enum TweetSections: String {
    case Tweet = "Tweet"
    case Reply = "Reply"
}

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTableView: UITableView!
    
    var tweet: Tweet!
    var replies: [Tweet]! = [Tweet]()
    
    var sections: [TweetSections] = [.Tweet, .Reply]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
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

extension TweetViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section] == TweetSections.Tweet {
            return 1
        }
        if sections[section] == TweetSections.Reply {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sections[indexPath.section] == TweetSections.Tweet {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetDetailCell") as! TweetDetailTableViewCell
            cell.tweet = tweet
            return cell
        }
        if sections[indexPath.section] == TweetSections.Reply {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell") as! ReplyTableViewCell
            cell.tweet = tweet
            return cell
        }
        return UITableViewCell()
    }
}
