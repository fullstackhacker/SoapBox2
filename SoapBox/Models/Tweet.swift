//
//  Tweet.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int?
    var user: User?
    var text: String?
    var createdAt: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    init(tweetDict: NSDictionary) {
        id = tweetDict["id"] as? Int
        user = User(userDict: tweetDict["user"] as! NSDictionary)
        text = tweetDict["text"] as? String
        retweetCount  = tweetDict["retweet_count"] as? Int ?? 0
        favoriteCount = tweetDict["favorite_count"] as? Int ?? 0
        
        // created at
        let timestampString = tweetDict["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.date(from: timestampString!)
    }
    
    class func tweetsWithArray(tweetDicts: [NSDictionary]) -> [Tweet] {
        return tweetDicts.map({ (tweetDict) -> Tweet in
            return Tweet(tweetDict: tweetDict)
        })
    }
    
    class func createTweet(_ text: String!, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        TwitterClient.getInstance().createTweet(
            text: text,
            success: { (tweetDict: NSDictionary!) -> Void in
                return success(Tweet(tweetDict: tweetDict))
            },
            failure: { (error) -> Void in
                return failure(error)
            }
        )
    }
    
    func reply(_ text: String!, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        TwitterClient.getInstance().replyToTweet(text: text, tweetId: self.id!, success: { (tweetDict) in
            success(Tweet(tweetDict: tweetDict!))
        }) { (error) in
            failure(error)
        }
    }
    
    func retweet(success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        TwitterClient.getInstance().retweet(self.id!, success: { (tweetDict) in
            success(Tweet(tweetDict: tweetDict!))
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    func like(success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        TwitterClient.getInstance().like(self.id!, success: { (tweetDict) in
            success(Tweet(tweetDict: tweetDict!))
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
}
