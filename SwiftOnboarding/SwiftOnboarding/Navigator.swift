//
//  Navigator.swift
//  SwiftOnboarding
//
//  Created by Radi on 7/24/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

public enum VCIDs : String {
    case PagesViewController,
    Page1ViewController,
    Page2ViewController,
    Page3ViewController
}

class Navigator: NSObject {
    public static func newVC(vcID : VCIDs) -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcID.rawValue)
    }
}
