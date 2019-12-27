//
//  File.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ProfileModel : NSObject{
    var record:CKRecord?
    
    var profileRecordID : CKRecord.ID {
        get{
            return record!.recordID
        }
    }
    
    var profileName : String {
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    var profileAddress : String {
        get{
            if let therapistAddress = record?.value(forKey: "parentAddress"){
                return therapistAddress as! String
            } else {
                return "no data"
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "parentAddress")
        }
    }
    
    var profilePhone : String {
        get{
            if let institutionName = record?.value(forKey: "parentPhone"){
                return institutionName as! String
            } else {
                return "no data"
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "parentPhone")
        }
    }
    
    var parentPhoto : UIImage{
        get{
            if let asset = record?["parentPhoto"] as? CKAsset,
                let data = NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    var userReference : String {
        get{
            return record?.value(forKey: "userReference") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "userReference")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
}
