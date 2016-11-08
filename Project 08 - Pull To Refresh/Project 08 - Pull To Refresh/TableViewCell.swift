//
//  TableViewCell.swift
//  Project 08 - Pull To Refresh
//
//  Created by 一川 黄 on 08/11/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
