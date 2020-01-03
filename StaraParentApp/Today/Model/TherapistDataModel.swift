//
//  TherapistDataModel.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 01/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class TherapistDataModel: NSObject{
    // student = child
    var record: CKRecord?
    
    var therapistRecordID : String {
        get{
            return record?.recordID.recordName as! String
        }
    }
    
    var therapistName : String {
        get{
            return record?.value(forKey: "therapistName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistName")
        }
    }
    
    var therapistAddress : String {
        get{
            return record?.value(forKey: "therapistAddress") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "therapistAddress")
        }
    }
    
    var institutionName : String {
        get{
            guard let institutionName = record?.value(forKey: "institutionName") else {
                return "No Institution"
            }
            return institutionName as! String
            
        }
        set{
            self.record?.setValue(newValue, forKey: "institutionName")
        }
    }
    
    
    var therapistPhoto : UIImage{
        get{
            if let asset = record?["therapistPhoto"] as? CKAsset,
                let data = NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    var isSelected =  false

    init(record: CKRecord){
        self.record = record
    }
}
