//
//  Variables.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

enum Theme : String {
    case black, dark, white
}

class Variables: NSObject {
    static var backgroundColor : UIColor = UIColor.black
    static var statusBarStyle : UIStatusBarStyle = UIStatusBarStyle.lightContent
    
    static func setTheme(theme: Theme) -> Void {
        var color = UIColor.white
        var style = UIStatusBarStyle.default
        
        switch theme {
        case .black:
            color = UIColor.black
            style = UIStatusBarStyle.lightContent
            break
        case .dark:
            color = UIColor.darkGray
            style = UIStatusBarStyle.lightContent
            break
        default:
            color = UIColor.white
            style = UIStatusBarStyle.default
            break
        }
        
        UserDefaults.standard.set(theme.rawValue, forKey: Constants.Keys.AppBackground)
        UserDefaults.standard.synchronize()
        Variables.backgroundColor = color
        Variables.statusBarStyle = style
    }
    
    static func getTheme() -> Theme {
        let savedTheme = UserDefaults.standard.value(forKey: Constants.Keys.AppBackground)
        var theme : Theme? = Theme.init(rawValue: savedTheme as! String)
        
        if theme == nil {
            theme = Theme.dark
        }
        
        self.setTheme(theme: theme!)
        return theme!
    }
}
