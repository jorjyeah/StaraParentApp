//
//  StudentListTableViewCell.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class StudentListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var studentNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
        // Configure the view for the selected state
    }

}
