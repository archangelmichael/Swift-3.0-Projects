//
//  CounterView.swift
//  CoreGraph
//
//  Created by Radi on 12/5/16.
//  Copyright © 2016 Oryx. All rights reserved.
//

import UIKit

let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var maxCount: Int = 8
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    @IBInspectable var arcWidth: CGFloat = 56
    
    @IBInspectable var currentCount: Int = 5 {
        didSet {
            if currentCount >= 0 && currentCount <=  maxCount {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    
    func changeCount(by change: Int) -> Void {
        if (change < 0 && currentCount == 0) ||
            (change > 0 && currentCount == maxCount) {
            return
        }
        
        currentCount = currentCount + change
    }
    
    func drawCounterText() -> Void {
        let offset : CGFloat = 10.0
        let lblXPos : CGFloat = arcWidth + offset
        let lblYPos : CGFloat = arcWidth + offset
        let lblWidth : CGFloat = bounds.width - 2 * lblXPos
        let lblHeight : CGFloat = bounds.height - 2 * lblYPos
        
        let lblFontSize : CGFloat = lblHeight > 50 ? 40 : 30
        
        let textRect = CGRect(x: lblXPos,
                              y: lblYPos,
                              width: lblWidth,
                              height: lblHeight)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attrs = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium",
                                                 size: lblFontSize)!,
                     NSParagraphStyleAttributeName : paragraphStyle,
                     NSForegroundColorAttributeName : UIColor.blue]
        
        let counterLabel = "\( currentCount == maxCount ? "OK" : "\(currentCount)")"
        counterLabel.draw(with: textRect,
                          options: .usesLineFragmentOrigin,
                          attributes: attrs,
                          context: nil)
    }
    
    override func draw(_ rect: CGRect) {
        
        let complete = currentCount >= maxCount
        
        let center = CGPoint(x: bounds.width/2,
                             y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)/2
        
        // Draw arc fill
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4

        let path = UIBezierPath(arcCenter: center,
                                radius: radius - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        if complete {
            path.lineWidth = arcWidth
            outlineColor.setStroke()
            path.stroke()
        }
        else {
            path.lineWidth = arcWidth
            counterColor.setStroke()
            path.stroke()
        }
        
        //Draw the outline
        if currentCount > 0 && !complete {
            let strokeWidth : CGFloat  = 5.0
            
            //first calculate the difference between the two angles
            //ensuring it is positive
            let angleDifference: CGFloat = 2 * π - startAngle + endAngle
            
            //then calculate the arc for each single glass
            let arcLengthPerGlass = angleDifference / CGFloat(maxCount)
            
            //then multiply out by the actual glasses drunk
            let outlineEndAngle = startAngle + arcLengthPerGlass * CGFloat(currentCount)
            
            //2 - draw the outer arc
            let outlinePath = UIBezierPath(arcCenter: center,
                                           radius: bounds.width/2 - strokeWidth/2,
                                           startAngle: startAngle,
                                           endAngle: outlineEndAngle,
                                           clockwise: true)
            
            //3 - draw the inner arc
            outlinePath.addArc(withCenter: center,
                               radius: bounds.width/2 - arcWidth + strokeWidth/2,
                               startAngle: outlineEndAngle,
                               endAngle: startAngle,
                               clockwise: false)
            
            //4 - close the path
            outlinePath.close()
            
            outlineColor.setStroke()
            outlinePath.lineWidth = strokeWidth
            outlinePath.stroke()
        }
        
        self.drawCounterText()
    }
}
