//
//  MenuViewController.swift
//  SlideInMenu
//
//  Created by Radi on 6/20/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var interactor : Interactor? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                                  action: #selector(self.handleGesture(gesture:)))
        self.view.addGestureRecognizer(pan)
    }
    
    @IBAction func onCloseMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func handleGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: gesture.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
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
