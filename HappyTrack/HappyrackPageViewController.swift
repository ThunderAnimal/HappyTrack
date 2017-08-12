//
//  HistoriePageViewController.swift
//  HappyTrack
//
//  Created by Martin Weber on 10.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit

class HappyTrackPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    let pages = ["HappyTrackViewContent1", "HappyTrackViewContent2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        //Set UP First Controller
        let controller = self.storyboard?.instantiateViewController(withIdentifier: pages[0])
        setViewControllers([controller!], direction: .forward, animated: true, completion: nil)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index > 0 {
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index-1])
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index < pages.count - 1 {
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index+1])
                }
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let identifier = viewControllers?.first?.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                return index
            }
        }
        return 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds // Why? I don't know.
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
}
