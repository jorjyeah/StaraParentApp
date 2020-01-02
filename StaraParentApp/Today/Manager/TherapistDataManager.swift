//
//  TherapistDataManager.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 01/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class TherapistDataManager{
    class func getTherapistData(therapistUID : [String], onComplete: @escaping ([TherapistDataModel]) -> Void){
        let therapistRef = therapistUID.map{ CKRecord.Reference(recordID: CKRecord.ID(recordName: $0), action: .none)}
        let predicate = NSPredicate(format: "userReference IN %@", therapistRef)
//
        var therapistDataModel = [TherapistDataModel]()
        
        let query = CKQuery(recordType: "Therapist", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                onComplete(therapistDataModel)
            } else {
                records?.forEach({ (record) in
                    let model = TherapistDataModel(record: record)
                    therapistDataModel.append(model)
                })
                onComplete(therapistDataModel)
            }
        }
    }
    
    class func checkAvailabilityStudent(onComplete : @escaping ([String]) -> Void){
        let childUID = UserDefaults.standard.string(forKey: "selectedStudent")
        var therapistUID = [String]()
        guard let childUserID : String = childUID as? String else {
            onComplete(therapistUID)
            return
        }
        let childUserRef = CKRecord.Reference(recordID: CKRecord.ID(recordName : childUserID), action: .none)
        
//        INI BUAT DATA DUMMY DULU
//        let childUID = "BC2819E0-35A0-174D-7CE4-2AB632112361"
//        let childUserRef = CKRecord.Reference(recordID: CKRecord.ID(recordName: childUID), action: .none)
        
        let predicate = NSPredicate(format: "childName == %@", childUserRef)
        let query = CKQuery(recordType: "TherapySchedule", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                onComplete(therapistUID.removingDuplicates())
            } else {
                records?.forEach({ (record) in
//                    let model = TherapistDataModel(record: record)
                    guard let therapist : CKRecord.Reference = record["therapistName"] else {
                        return
                    }
                    therapistUID.append(therapist.recordID.recordName)
                })
                onComplete(therapistUID.removingDuplicates())
            }
        }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
