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
//        dynamic based on selected student and therapist
//        let therapistID = String(UserDefaults.standard.string(forKey: "selectedTherapist")!)
//        let studentID = String(UserDefaults.standard.string(forKey: "selectedStudent")!)
        
        // ALBERT - George
        let therapistID = "_731c76d4c0c940893be5a27ee267e538"
        let studentID = "091A826D-28AE-1967-8FCF-C625BFBEFF7B"
        
        // DEA TANIA - Daniel
//        let therapistID = "_5e1d27febf7ab4148e69767ad6b9b4d3"
//        let studentID = "3DCB87C9-2EB4-7FB1-BFD3-27782FFA4DD1"
        
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
