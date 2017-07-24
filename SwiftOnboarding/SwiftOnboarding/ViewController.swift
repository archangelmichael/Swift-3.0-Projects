//
//  ViewController.swift
//  SwiftOnboarding
//
//  Created by Radi on 7/24/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onStart(_ sender: Any) {
        let pagesVC = Navigator.newVC(vcID: VCIDs.PagesViewController)
        self.present(pagesVC, animated: true, completion: nil)
    }

}

