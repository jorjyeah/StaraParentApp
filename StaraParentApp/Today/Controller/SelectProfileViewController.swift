//
//  SelectProfileViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class SelectProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentGenderAgeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
//    let studentListArray = ["Daniel", "George"]
    var studentListArray = [ChildrenDataModel]()
    var therapistListArray = [TherapistDataModel]()
    var studentSelected : ChildrenDataModel?
    var therapistSelected : TherapistDataModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        populateChildren()
        populateDetailsChild()
        // MARK: - Styling
        navigationController?.navigationBar.backItem?.title = "Back"
    }

    func populateTherapist(){
        let reloadGroup = DispatchGroup()
        
        reloadGroup.enter()
        TherapistDataManager.checkAvailabilityStudent { (arrayOfTherapistUID) in
            TherapistDataManager.getTherapistData(therapistUID: arrayOfTherapistUID) { (arrayOfTherapist) in
                self.therapistListArray = arrayOfTherapist
                print(self.therapistListArray.count)
                reloadGroup.leave()
            }
        }
        
        reloadGroup.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
    
    func populateDetailsChild(){
        let userDefaults = UserDefaults.standard
        
        self.studentNameLabel.text = userDefaults.string(forKey: "selectedStudentName")
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 2
        form.unitsStyle = .full
        form.allowedUnits = [.year, .month]
        guard let childDOB : Date = userDefaults.object(forKey: "selectedStudentDOB") as? Date else { return }
        guard let ageInYears = form.string(from: childDOB, to: Date()) else { return }
        guard let childGender : String = userDefaults.string(forKey: "selectedStudentGender") else { return }
        self.studentGenderAgeLabel.text = "\(childGender) , \(ageInYears) old"
    }
    
    func populateChildren(){
        let reloadGroup = DispatchGroup()
        
        reloadGroup.enter()
        ChildrenDataManager.getParentData { (parentModel) in
            ChildrenDataManager.getChildrenData(parentUID : parentModel.profileRecordID) { (arrayOfChildren) in
                self.studentListArray = arrayOfChildren
                print(self.studentListArray.count)
                reloadGroup.leave()
            }
        }
        
        reloadGroup.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
}

extension SelectProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           if section == 0 {
               return "Children"
           } else if section == 1 {
               return "Institution"
           } else {
               return " "
           }
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return studentListArray.count
        } else if section == 1 {
            return therapistListArray.count //atau pake institutionListArray.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentListTableViewCell
            cell.studentNameLabel.text = studentListArray[indexPath.row].childrentName
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "institutionCell", for: indexPath) as! InstitutionListTableViewCell
            cell.institutionNameLabel.text = therapistListArray[indexPath.row].institutionName + " - " + therapistListArray[indexPath.row].therapistName
        
            return  cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addInstitutionCell", for: indexPath) as! AddInstitutionTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //ini nanti switch akun student
            studentListArray[indexPath.row].isSelected = true
            studentSelected = studentListArray[indexPath.row]
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(studentSelected?.childrenRecordID, forKey: "selectedStudent")
            userDefaults.set(studentSelected?.childrentName, forKey: "selectedStudentName")
            userDefaults.set(studentSelected?.childGender, forKey: "selectedStudentGender")
            userDefaults.set(studentSelected?.childDOB, forKey: "selectedStudentDOB")
            
            populateDetailsChild()
            populateTherapist()
            
            
            
        } else if indexPath.section == 1 {
            //ini nanti switch institusi student
            therapistListArray[indexPath.row].isSelected = true
            therapistSelected = therapistListArray[indexPath.row]
            let userDefaults = UserDefaults.standard
            userDefaults.set(therapistSelected?.therapistRecordID, forKey: "selectedTherapist")
        } else if indexPath.section == 2{
            performSegue(withIdentifier: "showQRCode", sender: self)
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            //ini nanti switch akun student
//            studentListArray[indexPath.row].isSelected = false
//            studentSelected = studentListArray[indexPath.row]
//        } else if indexPath.section == 1 {
//            //ini nanti switch institusi student
//            therapistListArray[indexPath.row].isSelected = false
//            therapistSelected = studentListArray[indexPath.row]
//        }
//    }
}
