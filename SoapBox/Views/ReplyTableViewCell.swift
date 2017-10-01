//
//  ReplyTableViewCell.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/1/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {

    var tweet: Tweet!
    
    @IBOutlet weak var replyTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        replyTextField.becomeFirstResponder()
        replyTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ReplyTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // send reply
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
