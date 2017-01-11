//
//  ListCell.swift
//  mylist
//
//  Created by 池翔 on 2017/1/7.
//  Copyright © 2017年 池翔. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var customLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
