//
//  ProfileViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/6/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileHeaderImageView: UIImageView!
    @IBOutlet weak var userProfileTableView: UITableView!
    
    var user: User?
    
    func loadUser() {
        if let user = self.user ?? User.currentUser {
            self.user = user
            profileHeaderImageView.setImageWith(user.profileBannerUrl!)
            self.title = user.handle!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUser()
        
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self

        // Do any additional setup after loading the view.
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserProfileTableViewCell
        cell.user = user
        return cell
    }
    
    
}
