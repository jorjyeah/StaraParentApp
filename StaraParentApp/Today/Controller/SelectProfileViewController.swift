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
    let studentListArray = ["Daniel", "George"]
    let therapistListArray = ["Miss Bianca", "Miss Dea"]
    let institutionListArray = ["Dzone Therapy Center", "Anakku Therapy Center"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Styling
        navigationController?.navigationBar.backItem?.title = "Back"
    }


}

extension SelectProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           if section == 0 {
               return "PROFILE"
           } else if section == 1 {
               return "INSTITUTION"
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
            cell.studentNameLabel.text = studentListArray[indexPath.row]
            
            return  cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "institutionCell", for: indexPath) as! InstitutionListTableViewCell
            cell.institutionNameLabel.text = institutionListArray[indexPath.row] + " - " + therapistListArray[indexPath.row]
        
            return  cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addInstitutionCell", for: indexPath) as! AddInstitutionTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //ini nanti switch akun student
        } else if indexPath.section == 1 {
            //ini nanti switch institusi student
        } else if indexPath.section == 2{
            performSegue(withIdentifier: "showQRCode", sender: self)
        }
    }
}
