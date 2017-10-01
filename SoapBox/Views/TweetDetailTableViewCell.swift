//
//  TweetDetailTableViewCell.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/1/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var fulltimestampLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text! = tweet.text!
            profilePictureImageView.setImageWith(tweet.user!.profileImageUrl!)
            handleLabel.text = tweet.user!.handle!
            fullnameLabel.text = tweet.user!.fullname!
            
            //timestamp magic
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MM/d/y HH:mm:ss"
            fulltimestampLabel.text! = formatter.string(from: tweet.createdAt!)
        }
    }
    @IBAction func likeTweet(_ sender: Any) {
        tweet.like(success: {(tweet) -> Void in
            print(tweet)
        }, failure: { (error) -> Void in
            print(error)
        })
    }
    
    @IBAction func retweet(_ sender: Any) {
        tweet.retweet(success: {(tweet) -> Void in
            print(tweet)
        }, failure: { (error) -> Void in
            print(error)
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
