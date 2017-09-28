//
//  LoginViewController.swift
//  
//
//  Created by Mushaheed Kapadia on 9/26/17.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "4xNvYjA8PFwogWxMDZgOPIMeA", consumerSecret: "ynYmrqAumMFs6eg2Yk1K4Hu6rHa17iYuJs8IgHENKAxH0OAOUC")

        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterDemo://oauth")!, scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
            let urlString: String = "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken.token!)"
            let url: URL = URL(string: urlString)!
            print(urlString)
            UIApplication.shared.open(url, options: [String : Any](), completionHandler: { (success) in
                // do nothing right now
            })
        }, failure: {(error: Error?) -> Void in
            if let error = error {
                print(error)
            }
        })
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
