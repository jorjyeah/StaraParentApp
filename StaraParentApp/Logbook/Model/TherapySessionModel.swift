//
//  TherapySessionModel.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 27/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class TherapySessionModel: NSObject{
    var record:CKRecord?
     
    var therapySessionRecordID : CKRecord.ID {
         get{
             return record!.recordID
         }
     }
     
     var therapySessionDate : Date {
         get{
             return record?.value(forKey: "therapySessionDate") as! Date
         }
         set{
             self.record?.setValue(newValue, forKey: "therapySessionDate")
         }
     }
     
     var therapySessionNotes : String {
         get{
             return record?.value(forKey: "therapySessionNotes") as! String
         }
         set{
             self.record?.setValue(newValue, forKey: "therapySessionNotes")
         }
     }
     
     var childName : String {
         get{
             return record?.value(forKey: "childName") as! String
         }
         set{
             self.record?.setValue(newValue, forKey: "childName")
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
     
     init(record:CKRecord){
         self.record = record
     }
}
