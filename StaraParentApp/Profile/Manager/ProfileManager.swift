//
//  ProfileManager.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ProfileManager{
    
    class func addNewProfile(parentName: String, userReference: String, onComplete: @escaping(Bool) -> ()){
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        let record = CKRecord(recordType: "Parent")
        record.setObject(parentName as __CKRecordObjCValue, forKey: "parentName")
        let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userReference), action: CKRecord_Reference_Action.none)
        record.setObject(userReference as __CKRecordObjCValue, forKey: "userReference")
        database.save(record) { savedRecord, error in
            if savedRecord != nil{
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
    }
    
    class func getProfileData(userRef: String, onComplete: @escaping(ProfileModel) -> Void){
        let userReference =  CKRecord.Reference(recordID: CKRecord.ID(recordName: userRef), action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "userReference == %@", userReference)
        
        let query = CKQuery(recordType: "Parent", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        var profileModel : ProfileModel?
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                records?.forEach({ (record) in
                    let model = ProfileModel(record: record)
                    profileModel = model
                })
                onComplete(profileModel ?? error as! ProfileModel)
            }
        }
    }
    
    class func checkProfileData(userRef: String, onComplete: @escaping(Bool) -> ()){
        let userReference =  CKRecord.Reference(recordID: CKRecord.ID(recordName: userRef), action: CKRecord_Reference_Action.none)
        let predicate = NSPredicate(format: "userReference == %@", userReference)
        
        let query = CKQuery(recordType: "Parent", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if records!.count != 0{
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
    }
    
//    class func saveProfile(newData: [String], newProfilePicture: UIImage, profileData : CKRecord.ID, onComplete: @escaping (Bool) -> Void){
//
//        CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileData) { (record, error) in
//            DispatchQueue.main.async {
//                if error != nil {
//                    return
//                }
//                guard let record = record else {return}
//
//                if !( newData[0] == record["therapistName"] || newData[0] == "" ){
//                   record["therapistName"] = newData[0]
//                }
//
//                if !( newData[1] == record["institutionName"] || newData[1] == "" ) {
//                   record["institutionName"] = newData[1]
//                }
//
//                if !( newData[2] == record["therapistAddress"] || newData[2] == "" ){
//                   record["therapistAddress"] = newData[2]
//                }
//
//                let data = newProfilePicture.jpegData(compressionQuality: 90); // UIImage -> NSData, see also UIImageJPEGRepresentation
//                let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
//
//                do {
//                    try data!.write(to: url!, options: [])
//                } catch let e as NSError {
//                    print("Error! \(e)");
//                    return
//                }
//
//                record["therapistPhoto"] = CKAsset(fileURL: url!)
//
//                CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
//                    DispatchQueue.main.async {
//                        if error != nil {
//                            return
//                        }
//                        guard record != nil else {
//                            return
//                        }
//
//                        do { try FileManager.default.removeItem(at: url!) }
//                        catch let e { print("Error deleting temp file: \(e)") }
//                        onComplete(true)
//                    }
//                }
//            }
//        }
//    }
}
