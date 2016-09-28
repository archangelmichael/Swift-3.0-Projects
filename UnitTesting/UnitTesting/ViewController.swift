//
//  ViewController.swift
//  UnitTesting
//
//  Created by Radi on 9/28/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func sumUp(params: Int...) -> Int {
        var sum : Int = 0
        for param in params {
            sum += param
        }
        
        return sum
    }
}

