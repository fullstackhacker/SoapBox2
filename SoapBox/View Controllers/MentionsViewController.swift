//
//  MentionsViewController.swift
//  
//
//  Created by Mushaheed Kapadia on 10/8/17.
//

import UIKit

class MentionsViewController: UIViewController {

    @IBOutlet weak var mentionTableView: UITableView!
    
    var tweets: [Tweet]! = []
    var user: User? = User.currentUser ?? nil
    
    
    func loadTimeline(){
        TwitterClient.getInstance().mentionsTimeline(sinceId: nil, success: { (tweets) in
            self.tweets = tweets
            self.mentionTableView.reloadData()
        }) { (error) in
            print(error!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mentionTableView.dataSource = self
        mentionTableView.delegate = self
        
        mentionTableView.estimatedRowHeight = 250
        mentionTableView.rowHeight = UITableViewAutomaticDimension
        
        if let user = user {
            self.title = "Mentions: \(user.handle!)"
            self.loadTimeline()
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadTimeline()
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

extension MentionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionCell") as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    
}
