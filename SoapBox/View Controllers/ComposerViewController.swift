//
//  ComposerViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/30/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    let maxCharacters = 140

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func sendTweet(_ text: String){
        Tweet.createTweet(
            text,
            success: { (tweet) -> Void in
                print(tweet)
                let alert = UIALertController(title: "")
                self.dismiss(animated: true, completion: nil)
            },
            failure: { (error) -> Void in
                print(error)
                self.tweetTextView.isEditable = true
            }
        )
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

extension ComposerViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        if newString.count >= maxCharacters {
            return false
        }
        if (text == "\n") { // want to send tweet
            sendTweet(textView.text)
            textView.isEditable = false
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterCountLabel.text! = "\(textView.text.count)/\(maxCharacters)"

    }
}
