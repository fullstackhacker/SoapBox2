//
//  User.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class User: NSObject {

    var fullname: String?
    var handle: String?
    var profileImageUrl: URL?
    var profileBannerUrl: URL?
    var tagLine: String?
    var followersCount: Int?
    var followingCount: Int?
    var tweetsCount: Int?
    
    var userDict: NSDictionary!
    
    
    static var userDidLogoutNotification = NSNotification.Name(rawValue: "userDidLogout")
    
    init(userDict: NSDictionary) {
        print(userDict)
        fullname = userDict["name"] as? String
        handle = "@\(userDict["screen_name"] as? String ?? "")"
        profileImageUrl = URL(string: userDict["profile_image_url_https"] as? String ?? "")
        profileBannerUrl = URL(string: userDict["profile_banner_url"] as? String ?? "")
        tagLine = userDict["description"] as? String
        tweetsCount = userDict["statuses_count"] as? Int ?? 0
        followersCount = userDict["followers_count"] as? Int ?? 0
        followingCount = userDict["friends_count"] as? Int ?? 0
        self.userDict = userDict
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUser") as? Data
                if let userData = userData {
                    let userDict = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(userDict: userDict)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard

            var data: Data? = nil
            if let user = user {
                data = try! JSONSerialization.data(withJSONObject: user.userDict, options: [])
            }
            defaults.set(data, forKey: "currentUser")
            defaults.synchronize()
        }
    }
}
