//
//  TabsViewController.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabBarColor()
        self.viewControllers![0].tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(named: "calendar-off")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
                                                           selectedImage: UIImage(named: "calendar-on"))
        
        self.viewControllers![1].tabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(named: "settings-off")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
                                                          selectedImage: UIImage(named: "settings-on"))
        
        
    }
    
    func setTabBarColor() -> Void {
        self.tabBar.barTintColor = Variables.backgroundColor
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
