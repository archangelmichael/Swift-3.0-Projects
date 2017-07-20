//
//  MenuItem.swift
//  TableSections
//
//  Created by Radi on 7/20/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

enum MenuSection : String {
    case Leave,
    Approvals,
    Toolkit
    
    static let allValues = [Leave, Approvals, Toolkit]
}

class MenuItem: NSObject {
    var section: MenuSection
    var title: String = ""
    var actionTag : Int
    
    init(section: MenuSection, title: String, action: Int) {
        self.section = section
        self.title = title
        self.actionTag = action
        super.init()
    }
}
