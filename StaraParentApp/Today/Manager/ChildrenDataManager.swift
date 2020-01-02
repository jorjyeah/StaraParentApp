//
//  ChildrenDataManager.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 01/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class ChildrenDataManager{
    class func getChildrenData(parentUID : CKRecord.ID, onComplete: @escaping ([ChildrenDataModel]) -> Void){
        let parentUserRef = CKRecord.Reference(recordID: parentUID, action: .none)
        let predicate = NSPredicate(format: "parentName == %@", parentUserRef)
//
        var childrenDataModel = [ChildrenDataModel]()
        
        let query = CKQuery(recordType: "Child", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                onComplete(childrenDataModel)
            } else {
                records?.forEach({ (record) in
                    let model = ChildrenDataModel(record: record)
                    childrenDataModel.append(model)
                })
                onComplete(childrenDataModel)
            }
        }
    }
    
    class func getParentData(onComplete : @escaping (ProfileModel) -> Void){
        let uID = UserDefaults.standard.string(forKey: "userID")
        guard let userID = uID else {
            return
        }
        let userRef = CKRecord.Reference(recordID: CKRecord.ID(recordName: userID), action: .none)
        let predicate = NSPredicate(format: "userReference == %@", userRef)
        
        let query = CKQuery(recordType: "Parent", predicate: predicate)
        let database = CKContainer(identifier: "iCloud.com.jorjyeah.FinalChallengeAppNew").publicCloudDatabase
        // get just one value only
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["recordID"]
        
        var parentModel : ProfileModel?
        operation.recordFetchedBlock = { record in
            // process record
            parentModel = ProfileModel.init(record: record)
        }
        operation.queryCompletionBlock = { (cursor, error) in
            // Query finished
            DispatchQueue.main.async {
                if error == nil {
                    guard let parentDataModel = parentModel else {return}
                    onComplete(parentDataModel)
                } else {
                    print("error : \(error as Any)")
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    print(cursor as Any)
                }
            }
        }

        // addOperation
        database.add(operation)
    }
}
