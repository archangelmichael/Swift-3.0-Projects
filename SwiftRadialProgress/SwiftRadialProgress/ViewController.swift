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
    
    var progressLayer: CAShapeLayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetRandomProgress() {
        if progressLayer != nil {
            progressLayer!.removeFromSuperlayer()
        }
        
        
        
        
        let value = arc4random_uniform(MAX_VALUE)
        let progress = CGFloat(value)/CGFloat(MAX_VALUE)
        
        vProgress.layoutIfNeeded()
        
        let centerPoint = CGPoint (x: vProgress.bounds.width / 2,
                                   y: vProgress.bounds.width / 2);
        let circleRadius : CGFloat = vProgress.bounds.width / 2 * 0.83;
        
        
        
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: circleRadius,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true    );
        
        
        progressLayer = CAShapeLayer ();
        progressLayer?.path = circlePath.cgPath;
        progressLayer?.strokeColor = UIColor.green.cgColor;
        progressLayer?.fillColor = UIColor.clear.cgColor;
        progressLayer?.lineWidth = 10;
        progressLayer?.strokeStart = 0;
        progressLayer?.strokeEnd = 0.22;
        
        vProgress.layer.addSublayer(progressLayer!);
        progressLayer?.strokeEnd = progress;
        
        
    }

    @IBAction func onDraw(_ sender: Any) {
        SetRandomProgress()
    }

}

