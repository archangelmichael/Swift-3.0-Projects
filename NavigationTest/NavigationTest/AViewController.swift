//
//  AViewController.swift
//  NavigationTest
//
//  Created by Radi on 2/2/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "A"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goHome(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcHome",
                                                                 vcClass: ViewController.self)
    }
    
    @IBAction func goB(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcB",
                                                                 vcClass: BViewController.self)
    }
    
    @IBAction func goC(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcC",
                                                                 vcClass: CViewController.self)
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
