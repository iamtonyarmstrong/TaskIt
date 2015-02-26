//
//  TaskTableViewCell.swift
//  TaskIt
//
//  Created by Anthony Armstrong on 1/24/15.
//  Copyright (c) 2015 openinformant. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var subTaskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.backgroundColor = UIColor.yellowColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
