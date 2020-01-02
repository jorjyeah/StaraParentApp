//
//  SaveParentFeedback.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 30/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import Foundation
import CloudKit

class ParentFeedbackManager{
    class func saveFeedback(parentNotes: String, therapySessionRecordID: CKRecord.ID, onComplete: @escaping (ParentNotesModel,CKRecord.ID) -> Void){
        // save buat untuk dapet therapy session ID
        // yang nantinya disave di activitySessions
        var parentNotesRecordID = CKRecord.ID()
        let dateNow = Date()
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        let record = CKRecord(recordType: "ParentNotes")
        
        //        let therapistID = String(UserDefaults.standard.string(forKey: "selectedTherapistName")!)
        //        let studentID = String(UserDefaults.standard.string(forKey: "selectedStudentName")!)
        let therapistID = "_ea0bc15cf2724fb7d557dc0049ecdb01"
        let studentID = "BC2819E0-35A0-174D-7CE4-2AB632112361"
        let childRecordIDRef = CKRecord.Reference(recordID: CKRecord.ID(recordName: studentID), action: .none)
        let therapistRecordIDRef = CKRecord.Reference(recordID: CKRecord.ID(recordName: therapistID), action: .none)
        let therapySessionRecordIDRef = CKRecord.Reference(recordID: therapySessionRecordID, action: .none)
        
        record.setObject(childRecordIDRef as __CKRecordObjCValue, forKey: "childName")
        record.setObject(therapistRecordIDRef as __CKRecordObjCValue, forKey: "therapistName")
        record.setObject(therapySessionRecordIDRef as __CKRecordObjCValue, forKey: "therapySession")
        record.setObject(dateNow as __CKRecordObjCValue, forKey: "parentNoteDay")
        record.setObject(parentNotes as __CKRecordObjCValue, forKey: "parentNoteContent")
        database.save(record) { (savedRecord, error) in
            if savedRecord != nil{
                parentNotesRecordID = savedRecord!.recordID
                let parentNotesModel = ParentNotesModel.init(record: savedRecord!)
                onComplete(parentNotesModel, parentNotesRecordID)
            }
            print("err : \(error)")
        }
    }
}
