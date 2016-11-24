//
//  ViewController.swift
//  LocationRestrictions
//
//  Created by Radi on 9/27/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    var locationUpdated : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        locationUpdated = true
        self.map.delegate = self
    }
    
    @IBAction func onCenterToCountry(_ sender: AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.denied {
            self.getLocationFromPhoneRegionSettings()
        }
        else if status == CLAuthorizationStatus.notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
        else {
            self.locationUpdated = false
            self.manager.startUpdatingLocation()
        }
    }
    
    func getLocationFromPhoneRegionSettings() -> Void {
        let locale = Locale.current as NSLocale
        let countryCode = locale.object(forKey: NSLocale.Key.countryCode) as? String
        if countryCode != nil {
//            let countryName = locale.displayName(forKey: NSLocale.Key.identifier,
//                                                 value: countryCode!)
            // print("Country : \(countryName!) \(countryCode)")
            self.searchForLocation(byCountryName: countryCode!)
        }
        else {
            self.showBanner(message: "Unknown location")
        }
    }
    
    func searchForLocation(byCountryName : String) -> Void {
        let countryRequest = MKLocalSearchRequest()
        countryRequest.naturalLanguageQuery = byCountryName
        let countrySearch = MKLocalSearch(request: countryRequest)
        countrySearch.start { (responce, error) in
            if error != nil || responce == nil {
                print("No country found")
            }
            else {
                let locations = responce!.mapItems
                if locations.count > 0 {
                    let location1 : MKMapItem = locations.first!
                    let location2 : MKMapItem = locations.last!
                    
                    print("Location 1 : \(location1.placemark.country)")
                    if location1 != location2 {
                        print("Location 2 : \(location2.placemark.country)")
                    }
                    
                    self.showBanner(message: location1.placemark.country!)
                    self.map.setCenter(location1.placemark.coordinate,
                                       animated: false)
                }
            }
        }
    }
    
    func showBanner(message: String) -> Void {
        let sideOffset : CGFloat = 40
        let width : CGFloat = self.view.frame.size.width - 2 * sideOffset
        let topOffset : CGFloat = self.view.frame.size.height / 3
        
        let banner = UILabel(frame: CGRect(x: sideOffset,
                                           y: topOffset,
                                           width: width, height: 100))
        banner.textAlignment = NSTextAlignment.center
        banner.font = UIFont.boldSystemFont(ofSize: 30.0)
        banner.adjustsFontSizeToFitWidth = true
        banner.numberOfLines = 0
        banner.textColor = UIColor.red
        banner.backgroundColor = UIColor.white
        banner.layer.cornerRadius = 10
        banner.clipsToBounds = true
        banner.alpha = 0.0
        banner.text = message
        
        self.view.addSubview(banner)
        UIView.animateKeyframes(withDuration: 2.0,
                                delay: 0.0,
                                options: UIViewKeyframeAnimationOptions.calculationModeCubic,
                                animations:
            {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 1/4,
                                   animations: {
                    banner.alpha = 1.0
                })
                
                UIView.addKeyframe(withRelativeStartTime: 3/4,
                                   relativeDuration: 1/4,
                                   animations: {
                    banner.alpha = 0.0
                })
            }) { (complete) in
                if complete {
                    banner.removeFromSuperview()
                }
        }
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
            self.showPromptAlert(title: "Location access denied",
                                 message: "Want to turn it on?",
                                 closureOk:
                {
                    UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!,
                                              options: [:],
                                              completionHandler:
                        { (finished) in
                    })
                },
                                 closureNotOk: nil)
        }
        else {
            print("UNDEFINED")
            manager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : MKMapViewDelegate {
    
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse ||
            status == CLAuthorizationStatus.authorizedAlways {
            print("Authorized")
        }
        else if status == CLAuthorizationStatus.denied ||
            status == CLAuthorizationStatus.restricted {
            print("Denied")
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
        let lastLocation = locations.last
        if lastLocation != nil && self.locationUpdated == false {
            self.locationUpdated = true
            self.manager.stopUpdatingLocation()
            print("Last known location \(lastLocation!)")
            self.map.setCenter(lastLocation!.coordinate,
                               animated: false)
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
    
    func showPromptAlert(title: String,
                         message: String,
                         closureOk: (() -> Void)?,
                         closureNotOk: (() -> Void)?) -> Void {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionOk = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default)
        { (action) in
            if closureOk != nil {
                closureOk!()
            }
        }
        
        let actionNotOk = UIAlertAction(title: "NOT OK",
                                        style: UIAlertActionStyle.destructive)
        { (action) in
            if closureNotOk != nil {
                closureNotOk!()
            }
        }
        
        alertVC.addAction(actionOk)
        alertVC.addAction(actionNotOk)
        self.show(alertVC, sender: self)
    }
}

