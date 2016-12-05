//
//  ViewController.swift
//  CoreGraph
//
//  Created by Radi on 12/5/16.
//  Copyright © 2016 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vCounter: CounterView!
    @IBOutlet weak var btnPlus: PushButton!
    @IBOutlet weak var btnMinus: PushButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPlus(_ sender: Any) {
        self.vCounter.changeCount(by: 1)
    }
    
    @IBAction func onMinus(_ sender: Any) {
        self.vCounter.changeCount(by: -1)
    }


}

