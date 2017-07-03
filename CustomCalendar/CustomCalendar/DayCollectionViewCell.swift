//
//  DayCollectionViewCell.swift
//  CustomCalendar
//
//  Created by Radi on 6/21/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    public static let NibId : String = "DayCollectionViewCell"
    public static let ReuseId : String = "DayCell"
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var vMarker: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vMarker.layer.cornerRadius = self.vMarker.frame.size.width/2
        self.vMarker.clipsToBounds = true
    }

    public func setDayInfo(day: DayInfo) {
        self.lblCount.isHidden = !day.shouldDisplay()
        self.lblCount.text = "\(day.getDay())"
        self.vMarker.isHidden = day.isEmpty()
    }
}
