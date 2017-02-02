//
//  NavViewController.swift
//  NavigationTest
//
//  Created by Radi on 2/2/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeVC(vcClass: AnyClass) -> Void {
        print(self.viewControllers)
        var vcs = self.viewControllers
        for (index, vc) in vcs.enumerated() {
            if vc.isKind(of: vcClass) {
                vcs.remove(at: index)
                self.viewControllers = vcs
                print(self.viewControllers)
                return
            }
        }
    }

    func showVC(vcIdentifier: String, vcClass: AnyClass) -> Void {
        if vcIdentifier == "vcHome" {
            self.popToRootViewController(animated: true)
            return
        }
        
        
        for vc in self.viewControllers {
            if vc.isKind(of: vcClass) {
                self.popToViewController(vc, animated: true)
                return
            }
        }
        
        let vcNext = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcIdentifier)
        self.pushViewController(vcNext, animated: true)
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
