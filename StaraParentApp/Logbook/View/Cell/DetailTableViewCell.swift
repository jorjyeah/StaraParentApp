//
//  DetailTableViewCell.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
