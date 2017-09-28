//
//  User.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileImageUrl: URL?
    var tagLine: String?
    
    init(userDict: NSDictionary) {
        name = userDict["name"] as? String
        screenName = userDict["screen_name"] as? String
        profileImageUrl = URL(string: userDict["profile_image_url_https"] as? String ?? "")
        tagLine = userDict["description"] as? String
    }
}
