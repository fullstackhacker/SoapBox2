//
//  TweetViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/1/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var replyTextField: UITextField!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    var tweet: Tweet!

    func loadTweetProps() {
        fullnameLabel.text = tweet.user!.fullname!
        handleLabel.text = tweet.user!.handle!
        tweetTextLabel.text = tweet.text!
        profilePictureImageView.setImageWith(tweet.user!.profileImageUrl!)
        
        //timestamp magic
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestampLabel.text = formatter.string(from: tweet.createdAt!)
        
        // retweet image stuff
        if tweet.retweeted! {
            retweetImageView.image = #imageLiteral(resourceName: "retweeted")
        }
        else {
            retweetImageView.image = #imageLiteral(resourceName: "not-retweeted")
        }
        
        if tweet.liked! {
            likeImageView.image = #imageLiteral(resourceName: "liked")
        }
        else {
            likeImageView.image = #imageLiteral(resourceName: "unliked")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTextField.becomeFirstResponder()
        replyTextField.delegate = self
        
        loadTweetProps()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetTap(_ sender: Any) {
        
        if !tweet.retweeted! {
            tweet.retweet(success: {(tweet) -> Void in
                self.tweet = tweet
                self.loadTweetProps()
            }, failure: { (error) -> Void in
                print(error)
            })
        }
        else {
            tweet.unretweet(success: {(tweet) -> Void in
                self.tweet = tweet
                self.loadTweetProps()
            }, failure: { (error) -> Void in
                print(error)
            })
        }

    }
    
    @IBAction func likeTap(_ sender: Any) {
        
        if !tweet.liked! {
            tweet.like(success: {(tweet) -> Void in
                self.tweet = tweet
                self.loadTweetProps()
            }, failure: { (error) -> Void in
                print(error)
            })
        }
        else {
            tweet.unlike(success: {(tweet) -> Void in
                self.tweet = tweet
                self.loadTweetProps()
            }, failure: { (error) -> Void in
                print(error)
            })
        }
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

extension TweetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let replyText = "\(tweet.user!.handle!) \(textField.text!)"
        tweet.reply(
            replyText,
            success: { (tweet: Tweet) in
                print(tweet)
                textField.resignFirstResponder()
                textField.text = nil
            },
            failure: { (error: Error) in
                print(error)
            }
        )
        return false
    }
}
