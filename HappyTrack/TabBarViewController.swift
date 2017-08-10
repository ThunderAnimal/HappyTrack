//
//  TabBarViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 10.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        get {
            return false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers!
        guard let toIndex = tabViewControllers.index(of: viewController) else {
            return false
        }
        
        // Our method
        animateToTab(toIndex: toIndex)
        
        return true
    }
    
    func animateToTab(toIndex: Int) {
        let tabViewControllers = viewControllers!
        let fromView = selectedViewController!.view
        let toView = tabViewControllers[toIndex].view
        let fromIndex = tabViewControllers.index(of: selectedViewController!)
        
        guard fromIndex != toIndex else {return}
        
        // Add the toView to the tab bar view
        fromView?.superview!.addSubview(toView!)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.transition(from: fromView!, to: toView!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, completion: { finished in
            
            // Remove the old view from the tabbar view.
            fromView?.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
    
}
