//
//  UserProfileTableViewCell.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/6/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var user: User! {
        didSet {
            profilePictureImageView.setImageWith(user.profileImageUrl!)
            fullnameLabel.text = user.fullname
            tweetCountLabel.text = "\(user.tweetsCount!) Tweets"
            followersLabel.text = "\(user.followersCount!) Followers"
            followingLabel.text = "\(user.followingCount!) Following"
        }
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
