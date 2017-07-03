//
//  ViewController.swift
//  CustomCalendar
//
//  Created by Radi on 6/21/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let DaysInCalendar : Int = 42
    
    var currentDate : Date = Date()
    var days : [DayInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dayCell = UINib(nibName: DayCollectionViewCell.NibId,
                            bundle: Bundle.main)
        self.collectionView.register(dayCell,
                                     forCellWithReuseIdentifier: DayCollectionViewCell.ReuseId)
        
        self.currentDate = Date()
        self.loadDays()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    @IBAction func onPrev(_ sender: UIButton) {
        let calendar = NSCalendar.current
        if let newDate = calendar.date(byAdding: Calendar.Component.month,
                                       value: -1,
                                       to: self.currentDate) {
            self.currentDate = newDate
        }
        
        self.loadDays()
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        let calendar = NSCalendar.current
        if let newDate = calendar.date(byAdding: Calendar.Component.month,
                                       value: 1,
                                       to: self.currentDate) {
            self.currentDate = newDate
        }
        
        self.loadDays()
    }

    func loadDays() -> Void {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self.currentDate)!
        let numDays = range.count
        
        if let monthStartDay = self.currentDate.dayOfMonth() {
            let startDate = calendar.date(byAdding: Calendar.Component.day,
                                          value: 1-monthStartDay,
                                          to: self.currentDate)
            print(startDate)
        }
        
        
        
        
        
        
        
//        if let weekDayNumber = self.currentDate.dayNumberOfWeek() {
//            let startDayOffset = weekDayNumber - 1
//            var startDate = calendar.date(byAdding: Calendar.Component.month,
//                                          value: -startDayOffset,
//                                          to: self.currentDate)
//            if startDate != nil {
//                self.days = []
//                
//                if startDayOffset > 0 {
//                    for i in 0...startDayOffset - 1 {
//                        self.days.append(DayInfo(date: startDate!, count: 0, show: false))
//                        startDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate!)
//                    }
//                }
//                
//                for day in self.days {
//                    print(day.getDate())
//                }
//            }
//            
//            //print(weekDayNumber)
//        }
//        
//        if let weekDay = self.currentDate.dayOfWeek() {
//            //print(weekDay)
//        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 // DaysInCalendar
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.ReuseId,
                                                      for: indexPath) as? DayCollectionViewCell
        if (cell == nil) {
            cell = DayCollectionViewCell()
        }
        
        let day = self.days[indexPath.row]
        cell?.setDayInfo(day: day)
        return cell!
    }
}

extension ViewController : UICollectionViewDelegate {
    
}


extension Date {
    func dayOfMonth() -> Int? {
        return Calendar.current.component(.day, from: self)
    }
    
    func dayNumberOfWeek() -> Int? {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.dateComponents([.weekday], from: self).weekday
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
