//
//  PageTableViewCell.swift
//  SoapBox
//
//  Created by Mushaheed Kapadia on 10/4/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class PageTableViewCell: UITableViewCell {

    @IBOutlet weak var pageTitleLabel: UILabel!
    
    var page: String! {
        didSet {
            pageTitleLabel.text = page
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
