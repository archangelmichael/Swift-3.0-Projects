//
//  WebTableViewCell.swift
//  TableCellAutoHeightWebView
//
//  Created by Radi on 9/26/16.
//  Copyright © 2016 archangel. All rights reserved.
//

import UIKit

class WebTableViewCell: UITableViewCell {

    @IBOutlet weak var ivAvatar: UIImageView!
    
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var wvContent: UIWebView!
    @IBOutlet weak var cstrWVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnOptions: UIButton!
    
    static let defaultHeight : CGFloat = 100.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wvContent.scrollView.isScrollEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
