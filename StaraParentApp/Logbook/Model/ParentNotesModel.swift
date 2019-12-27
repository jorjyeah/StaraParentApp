//
//  ParentNotesModel.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 27/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import CloudKit

class ParentNotesModel: NSObject{
    var record:CKRecord?
    
    var parentNoteDay : Date {
        get{
            return record?.value(forKey: "parentNoteDay") as! Date
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteDay")
        }
    }
    
    var parentNoteContent : String {
        get{
            return record?.value(forKey: "parentNoteContent") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentNoteContent")
        }
    }
    
    var therapySession : CKRecord.ID {
        get{
            let therapySession : CKRecord.Reference?
            therapySession = record?.value(forKey: "therapySession") as? CKRecord.Reference
            if let therapySession = therapySession?.recordID{
                return therapySession
            } else {
                return (therapySession?.recordID ?? nil)!
            }
        }
        set{
            self.record?.setValue(newValue, forKey: "therapySession")
        }
    }
    
    var studentName : String {
        get{
            return record?.value(forKey: "childName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "childName")
        }
    }
    
    var parentName : String {
        get{
            return record?.value(forKey: "parentName") as! String
        }
        set{
            self.record?.setValue(newValue, forKey: "parentName")
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
}

