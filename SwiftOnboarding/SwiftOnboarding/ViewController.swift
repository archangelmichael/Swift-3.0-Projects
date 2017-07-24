//
//  ViewController.swift
//  SwiftOnboarding
//
//  Created by Radi on 7/24/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [Navigator.newVC(vcID: VCIDs.Page1ViewController),
                Navigator.newVC(vcID: VCIDs.Page2ViewController),
                Navigator.newVC(vcID: VCIDs.Page3ViewController)]
    }()
    
    var pagesVC : UIPageViewController?
    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vPages: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func displayPages(pages: UIPageViewController) {
        pages.view.alpha = 0.3
        
        vPages.numberOfPages = orderedViewControllers.count
        vPages.currentPage = 0
        
        self.addChildViewController(pages)
        
        pages.view.translatesAutoresizingMaskIntoConstraints = false
        vContainer.addSubview(pages.view)
        
        NSLayoutConstraint.activate([
            pages.view.leadingAnchor.constraint(equalTo: vContainer.leadingAnchor),
            pages.view.trailingAnchor.constraint(equalTo: vContainer.trailingAnchor),
            pages.view.topAnchor.constraint(equalTo: vContainer.topAnchor),
            pages.view.bottomAnchor.constraint(equalTo: vContainer.bottomAnchor)
            ])
        
        pages.didMove(toParentViewController: self)
    }
    
    func hidePages(pages: UIPageViewController) {
        pages.willMove(toParentViewController: self)
        pages.view.removeFromSuperview()
        pages.removeFromParentViewController()
    }

    @IBAction func onStart(_ sender: Any) {
        self.pagesVC = Navigator.newVC(vcID: VCIDs.PagesViewController) as? UIPageViewController
        if self.pagesVC != nil {
            self.pagesVC!.dataSource = self
            self.pagesVC!.delegate = self
            
            if let firstViewController = orderedViewControllers.first {
                self.pagesVC!.setViewControllers([firstViewController],
                                           direction: .forward,
                                           animated: true,
                                           completion: nil)
                self.displayPages(pages: self.pagesVC!)
            }
        }
    }

    @IBAction func onSkip(_ sender: Any) {
        if self.pagesVC != nil {
            self.hidePages(pages: self.pagesVC!)
        }
    }
}

extension ViewController : UIPageViewControllerDataSource {
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
        guard let firstViewController = pageViewController.viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}

extension ViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            if let currentVC = pageViewController.viewControllers?.last {
                if let viewControllerIndex = orderedViewControllers.index(of: currentVC) {
                    self.vPages.currentPage = viewControllerIndex
                }
            }
        }
    }
}

