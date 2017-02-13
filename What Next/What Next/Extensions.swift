//
//  Extensions.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

extension UIViewController {
    func setBackgroundColor() -> Void {
        self.view.backgroundColor = Variables.backgroundColor
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension UIButton {
    func roundCorners() -> Void {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
