//
//  ViewController.swift
//  SwiftRadialProgress
//
//  Created by Radi on 7/26/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vProgress: UIView!
    
    let MAX_VALUE : UInt32 = 180;
    let MIN_VALUE = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func ClearSublayers(view : UIView) {
        view.layer.sublayers?.removeAll()
    }
    
    func GetAnimatedProgressLayer() -> CAShapeLayer {
        let circle = CAShapeLayer()
        let centerPoint = CGPoint (x: vProgress.bounds.width / 2,
                                   y: vProgress.bounds.width / 2);
        let circleRadius : CGFloat = vProgress.bounds.width / 2 * 0.83;
        
        
        let value = arc4random_uniform(MAX_VALUE)
        let progress = CGFloat(value)/CGFloat(MAX_VALUE)
        let progressInDegrees : CGFloat = 360 * progress
        
        let clockwise = false
        let startAngle : CGFloat = 90
        
        let endAngle = clockwise ? startAngle + progressInDegrees : startAngle - progressInDegrees
        
        let startAngleRad = startAngle.degreesToRadians
        let endAngleRad = endAngle.degreesToRadians
        
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: circleRadius,
                                      startAngle: CGFloat(startAngleRad),
                                      endAngle: CGFloat(endAngleRad),
                                      clockwise: clockwise);

        circle.path = circlePath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.green.cgColor
        circle.lineWidth = 20
        circle.lineCap = "round"
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1;
        animation.isRemovedOnCompletion = false;
        animation.fromValue = 0;
        animation.toValue = 1;
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        circle.add(animation, forKey: "drawCircleAnimation")
        return circle;
    }

    @IBAction func onDraw(_ sender: Any) {
        self.ClearSublayers(view: vProgress)
        let animLayer = self.GetAnimatedProgressLayer()
        vProgress.layer.addSublayer(animLayer)
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

