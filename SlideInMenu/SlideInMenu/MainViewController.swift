//
//  MainViewController.swift
//  SlideInMenu
//
//  Created by Radi on 6/20/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let interactor = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan : UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                                                          action: #selector(self.edgePanGesture(gesture:)))
        edgePan.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgePan)
    }
    
    @IBAction func onMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "showMenu", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
        }
    }
    
    func edgePanGesture(gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation,
                                                    viewBounds: view.bounds,
                                                    direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(gestureState:  gesture.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "showMenu", sender: nil)
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
