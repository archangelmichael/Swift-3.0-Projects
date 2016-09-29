//
//  ViewController.swift
//  DeepLinks
//
//  Created by Radi on 9/29/16.
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

    @IBAction func onGoDeeper(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "level1")
        self.navigationController?.pushViewController(vc1,
                                                      animated: true)
    }

}

