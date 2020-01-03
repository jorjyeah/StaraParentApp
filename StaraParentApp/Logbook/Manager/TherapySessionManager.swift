//
//  TherapySessionManager.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 27/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class TherapySessionManager{
    class func getTherapySession(onComplete: @escaping ([TherapySessionModel]) -> Void){
        var therapySessionModel = [TherapySessionModel]()
//        
//        let therapistID = String(UserDefaults.standard.string(forKey: "selectedTherapist")!)
//        let studentID = String(UserDefaults.standard.string(forKey: "selectedStudent")!)
        let therapistID = "_ea0bc15cf2724fb7d557dc0049ecdb01"
        let studentID = "BC2819E0-35A0-174D-7CE4-2AB632112361"
        
        let studentReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: studentID), action: .none)
        let therapistReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistID), action: .none)
        
        let predicate = NSPredicate(format: "childName == %@ AND therapistName  == %@", studentReference, therapistReference)
        
        let query = CKQuery(recordType: "TherapySession", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "therapySessionDate", ascending: false)]
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = TherapySessionModel(record: record)
                    therapySessionModel.append(model)
                    // harus append or = aja?
                })
                onComplete(therapySessionModel)
            }
        }
    }
}
