//
//  TweetTableViewCell.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/30/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

@objc protocol TweetTableViewCellDelegate {
    @objc optional func showUser(sender: TweetTableViewCell)
}

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var delegate: TweetTableViewCellDelegate?

    var tweet: Tweet! {
        didSet {
            fullNameLabel.text! = tweet.user!.fullname!
            handleLabel.text! = tweet.user!.handle!
            tweetTextLabel.text! = tweet.text!
            
            //timestamp magic
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/d/y"
            timestampLabel.text! = formatter.string(from: tweet.createdAt!)
            
            profilePictureImageView.setImageWith(tweet.user!.profileImageUrl!)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            tap.delegate = self
            profilePictureImageView.isUserInteractionEnabled = true
            profilePictureImageView.addGestureRecognizer(tap)
        }
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        print(tweet.user!.handle!)
        delegate?.showUser!(sender: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profilePictureImageView.layer.cornerRadius = 3
        self.profilePictureImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
