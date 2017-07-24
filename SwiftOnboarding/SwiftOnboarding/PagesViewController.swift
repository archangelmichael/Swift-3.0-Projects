//
//  PagesViewController.swift
//  SwiftOnboarding
//
//  Created by Radi on 7/24/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class PagesViewController: UIPageViewController {
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [Navigator.newVC(vcID: VCIDs.Page1ViewController),
                Navigator.newVC(vcID: VCIDs.Page2ViewController),
                Navigator.newVC(vcID: VCIDs.Page3ViewController)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
       
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                                direction: .forward,
                                animated: true,
                                completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PagesViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }

}
