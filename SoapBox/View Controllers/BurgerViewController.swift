//
//  BurgerViewController.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/4/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class BurgerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    
    var menuViewController: MenuViewController! {
        didSet (oldMenuViewController){
            view.layoutIfNeeded()
            
            if oldMenuViewController != nil {
                oldMenuViewController.willMove(toParentViewController: nil)
                oldMenuViewController.view.removeFromSuperview()
                oldMenuViewController.didMove(toParentViewController: nil)
            }
            
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    var contentViewController: UINavigationController! {
        didSet (oldContentViewController){
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            UIView.animate(withDuration: 0.3) {
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.burgerViewController = self
        contentViewController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        }
        else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        }
        else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 100
                }
                else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
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
