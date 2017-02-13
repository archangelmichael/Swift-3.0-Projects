//
//  Alerts.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class Alerts: NSObject {
    static func showOkAlert(title: String?,
                            message: String?,
                            handler: ((UIAlertAction) -> Void)?,
                            sender: UIViewController) -> Void {
        let alertVC = UIAlertController.init(title: title,
                                             message: message,
                                             preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(UIAlertAction.init(title: "OK",
                                             style: .default,
                                             handler: handler))
        sender.present(alertVC, animated: true, completion: nil)
    }
}
