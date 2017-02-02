//
//  ViewController.swift
//  NavigationTest
//
//  Created by Radi on 2/2/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goA(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcA",
                                                                 vcClass: AViewController.self)
    }
    
    @IBAction func goB(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcB",
                                                                 vcClass: BViewController.self)
    }
    
    @IBAction func goC(_ sender: Any) {
        (self.navigationController as! NavViewController).showVC(vcIdentifier: "vcC",
                                                                 vcClass: CViewController.self)
    }

}

