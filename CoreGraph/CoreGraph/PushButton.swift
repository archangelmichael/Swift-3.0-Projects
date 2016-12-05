//
//  PushButton.swift
//  CoreGraph
//
//  Created by Radi on 12/5/16.
//  Copyright © 2016 Oryx. All rights reserved.
//

import UIKit


@IBDesignable class PushButton: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
     
        //set up the width and height variables
        //for the horizontal stroke
        let plusWidth: CGFloat = 3.0
        let plusSize: CGFloat = min(bounds.width, bounds.height) * 0.6
        let pixelFix : CGFloat = 0.5
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusWidth
        
        // Draw horizontal line
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusSize/2 + pixelFix,
            y:bounds.height/2 + pixelFix))
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusSize/2 + pixelFix,
            y:bounds.height/2 + pixelFix))
        
        if isAddButton {
            // Draw vertical line
            plusPath.move(to: CGPoint(
                x:bounds.width/2 + pixelFix,
                y:bounds.height/2 - plusSize/2 + pixelFix))
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(
                x:bounds.width/2 + pixelFix,
                y:bounds.height/2 + plusSize/2 + pixelFix))
        }
        
        //set the stroke color
        UIColor.white.setStroke()
        //draw the stroke
        plusPath.stroke()
    }

}
