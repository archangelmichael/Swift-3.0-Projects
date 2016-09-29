//
//  Level1ViewController.swift
//  DeepLinks
//
//  Created by Radi on 9/29/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class Level1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGoDeeper(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "level2")
        self.navigationController?.pushViewController(vc1,
                                                      animated: true)
    }

    @IBAction func onGoBack(_ sender: AnyObject) {
        _ = self.navigationController?.popToRootViewController(animated: true)
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
