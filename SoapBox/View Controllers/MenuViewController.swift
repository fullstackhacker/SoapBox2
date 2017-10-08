//
//  MenuViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/4/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    
    var burgerViewController: BurgerViewController!
    var homeTimelineNavigationController: UINavigationController!
    var userProfileNavigationController: UINavigationController!
    var mentionsNavigationController: UINavigationController!

    
    let pages: [String] = ["Home", "Profile", "Mentions"]
    var pageViewControllers: [UINavigationController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.estimatedRowHeight = 250
        menuTableView.rowHeight = UITableViewAutomaticDimension
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeTimelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        userProfileNavigationController = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UINavigationController
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "Mentions") as! UINavigationController
        

        pageViewControllers.append(homeTimelineNavigationController)
        pageViewControllers.append(userProfileNavigationController)
        pageViewControllers.append(mentionsNavigationController)

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


extension MenuViewController: TweetTableViewCellDelegate {
    func showUser(sender: TweetTableViewCell) {
        if let userProfileViewController = userProfileNavigationController.topViewController as? ProfileViewController {
            userProfileViewController.user = sender.tweet.user
            burgerViewController.contentViewController = userProfileNavigationController
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "menuCell") as! PageTableViewCell
        cell.page = self.pages[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pages.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        let pageViewNavigationController = pageViewControllers[indexPath.row]
        if let pageViewController = pageViewNavigationController.topViewController as? TweetsViewController {
            pageViewController.menuViewController = self
        }
        if let pageViewController = pageViewNavigationController.topViewController as? ProfileViewController {
            pageViewController.user = nil
        }
        burgerViewController.contentViewController = pageViewNavigationController
    }
}
