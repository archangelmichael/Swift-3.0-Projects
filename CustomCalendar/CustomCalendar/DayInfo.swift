//
//  DayInfo.swift
//  CustomCalendar
//
//  Created by Radi on 6/21/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class DayInfo: NSObject {
    private var date : Date
    private var count : Int
    private var show : Bool
    
    init(date: Date, count: Int, show : Bool = false) {
        self.date = date
        self.count = count
        self.show = show
    }
    
    public func getDate() -> Date {
        return self.date
    }
    
    public func getDay() -> Int {
        if let day = date.dayOfMonth() {
            return day
        }
        
        return 0
    }
    
    public func getCount() -> Int {
        return self.count
    }
    
    public func shouldDisplay() -> Bool {
        return self.show
    }
    
    public func isEmpty() -> Bool {
        return count <= 0
    }
}
