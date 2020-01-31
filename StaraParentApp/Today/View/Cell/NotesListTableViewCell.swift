//
//  NotesTableViewCell.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class NotesListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var notesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        notesLabel.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        notesLabel.layer.cornerRadius = 4
//        notesLabel.layer.borderWidth = 0.5
//        notesLabel.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
