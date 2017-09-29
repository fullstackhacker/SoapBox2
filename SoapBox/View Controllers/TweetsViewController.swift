//
//  TweetsViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 9/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet]! = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.getInstance().homeTimeline(success: { (tweets) in
            self.tweets = tweets
            print(tweets)
        }) { (error) in
            if let err = error {
                print(err)
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.getInstance().logout()
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
