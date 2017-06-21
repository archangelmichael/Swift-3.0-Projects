//
//  DismissMenuAnimator.swift
//  SlideInMenu
//
//  Created by Radi on 6/21/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class DismissMenuAnimator: NSObject {

}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        if let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber) {
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           animations:
                {
                    snapshot.frame = CGRect(origin: CGPoint.zero,
                                            size: UIScreen.main.bounds.size)
            })
            {
                (complete) in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    containerView.insertSubview(toVC.view,
                                                aboveSubview: fromVC.view)
                    snapshot.removeFromSuperview()
                }
                
                transitionContext.completeTransition(didTransitionComplete)
            }
        }
    }
}
