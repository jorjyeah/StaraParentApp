//
//  ParentNotesManager.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 27/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ParentNotesManager{
    class func getParentNotes(therapySessionID : [CKRecord.ID], onComplete: @escaping ([ParentNotesModel]) -> Void){
        var parentNotesModel = [ParentNotesModel]()
        
        let therapySessionReference = therapySessionID.map{ CKRecord.Reference(recordID: $0, action: .none) }
        
        let predicate = NSPredicate(format: "therapySession IN %@", therapySessionReference)
        
        let query = CKQuery(recordType: "ParentNotes", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "parentNoteDay", ascending: false)]
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                records?.forEach({ (record) in
                    let model = ParentNotesModel(record: record)
                    parentNotesModel.append(model)
                })
                onComplete(parentNotesModel)
            }
        }
    }
}
