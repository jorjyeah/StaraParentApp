//
//  ChildrenDataModel.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 01/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ChildrenDataModel: NSObject{
//    func encode(with coder: NSCoder) {
//        coder.encode(childrenRecordID, forKey: "childrenRecordID")
//        coder.encode(childrentName, forKey: "childrentName")
//        coder.encode(childDOB, forKey: "childDOB")
//        coder.encode(childGender, forKey: "childGender")
//        coder.encode(parentRecordID, forKey: "parentRecordID")
//        coder.encode(isSelected, forKey: "isSelected")
//    }
    
//    init(childrenRecordID:String, childrentName:String, childDOB:Date, childGender:String, parentRecordID:String, isSelected:Bool){
//        self.childrenRecordID = childrenRecordID
//        self.childrentName = childrentName
//        self.childDOB = childDOB
//        self.childGender = childGender
//        self.parentRecordID = parentRecordID
//        self.isSelected = isSelected
//    }
    
//    required convenience init(coder decoder: NSCoder) {
//        let childrenRecordID = decoder.decodeObject(forKey: "childrenRecordID") as! String
//        let childrentName = decoder.decodeObject(forKey: "childrentName") as! String
//        let childDOB = decoder.decodeObject(forKey: "childDOB") as! Date
//        let childGender = decoder.decodeObject(forKey: "childGender") as! String
//        let parentRecordID = decoder.decodeObject(forKey: "parentRecordID") as! String
//        let isSelected = decoder.decodeObject(forKey: "isSelected") as! Bool
//
//        let record = CKRecord.init(recordType: "Child", recordID: CKRecord.ID(recordName: childrenRecordID))
//        self.init(childrenRecordID:childrenRecordID, childrentName:childrentName, childDOB:childDOB, childGender:childGender, parentRecordID:parentRecordID, isSelected:isSelected)
//    }
    
    // student = child
    var record: CKRecord?
    
    var childrenRecordID : String {
        get{
            return record?.recordID.recordName as! String
        }
        set{
            self.record?.recordID.recordName
        }
    }
    
    var childrentName : String {
        get{
            return record?.value(forKey: "childName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childName")
        }
    }
    
    var childGender : String {
        get{
            return record?.value(forKey: "childGender") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childGender")
        }
    }
    
    var childDOB : Date {
        get{
            return record?.value(forKey: "childDOB") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "childDOB")
        }
    }
    
    var childPhoto : UIImage{
        get{
            if let asset = record?["childPhoto"] as? CKAsset,
                let data = NSData(contentsOf: (asset.fileURL)!),
                let image = UIImage(data: data as Data)
            {
                return image
            }
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    var parentRecordID : String{
        get{
            guard let parentRecordID = record?.value(forKey: "parentName") else {
                return "No Parent"
            }
            let recordRef = self.record?.value(forKey: "parentName") as! CKRecord.Reference
            let recordID = recordRef.recordID.recordName
            return recordID
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    var isSelected =  false

    init(record: CKRecord){
        self.record = record
    }
}
