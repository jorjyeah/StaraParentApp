//
//  ViewDetailViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ViewDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var howToLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    @IBOutlet weak var helpfulTipsLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var imageAttachment: UIImageView!
    
    // MARK: - Properties
    var activity:String?
    var prompt:String?
    var media:String?
    var howTo:String?
    var example:String?
    var tips:String?
    var skill:CKRecord.ID?
    var program:CKRecord.ID?
    var image:String?
    var audio:String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.activityNameLabel.text = self.activity
            self.howToLabel.text = self.howTo
            self.promptLabel.text = self.prompt
            self.mediaLabel.text = self.media
            self.helpfulTipsLabel.text = self.tips
            ReadableData.translateSkill(skillRecordID: self.skill!) { (readableSkill) in
                self.skillLabel.text = readableSkill
            }
            ReadableData.translateBaseProgram(baseProgramRecordID: self.program!) { (readableBaseProgram) in
                self.programLabel.text = readableBaseProgram
            }
        }

    }
    

   
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
