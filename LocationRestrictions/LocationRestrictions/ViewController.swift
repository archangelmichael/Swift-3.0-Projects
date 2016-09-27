//
//  ViewController.swift
//  LocationRestrictions
//
//  Created by Radi on 9/27/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = 50.0
        manager.requestWhenInUseAuthorization()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onRequestLocation(_ sender: AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            print("WHEN IN USE")
        }
        else if status == CLAuthorizationStatus.authorizedAlways {
            print("ALWAYS")
        }
        else if (status == CLAuthorizationStatus.denied) {
            print("DENIED")
            self.manager.requestWhenInUseAuthorization()
            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!,
                                      options: [:],
                                      completionHandler: { (finished) in
                                        
            })
        }
        else {
            print("UNDEFINED")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse ||
            status == CLAuthorizationStatus.authorizedAlways) {
            print("Authorized")
        }
        else {
            print("Not authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        let locationError = CLError(_nsError: error as NSError)
        
        switch (locationError.code) {
        case CLError.locationUnknown:  // unable to obtain a location
            self.showAlert(title: "Location error",
                           message: "Unknown location")
            break
        case CLError.denied: //Access to the location service was denied by the user.
            self.showAlert(title: "Location error",
                           message: "Access denied")
            break
        case CLError.network: //The network was unavailable or a network error occurred.
            self.showAlert(title: "Location error",
                           message: "Network error")
            break
        default:
            self.showAlert(title: "Location error",
                           message: "Undefined error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print("Last known location \(lastLocation)")
        }
    }
    
    func showAlert(title: String, message: String) -> Void {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionOk = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default) { (action) in
            
        }
        
        alertVC.addAction(actionOk)
        self.show(alertVC, sender: self)
    }
}

