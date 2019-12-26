//
//  TherapistDetailViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class TherapistDetailViewController: UIViewController {
    
// MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let activityArray = ["Stomp Feet", "Bear Hug"]
    let promptArray = ["Gesture", "Verbal"]
    let mediaArray = ["Ground", "-"]
    let notes = ["Molly was crying while doing the stomp feet today. If Molly starts crying again while doing it, plese don't force her to do it."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension TherapistDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEEE, d MMM yyyy"
//            return "Activities on \(formatter.string(from: therapySessionDate))" // diganti date dari Data
            return "Activity on Fri, 18 Oct 2019"
        }
        else {
            return "Notes"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0 {
            return activityArray.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 128
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.section == 0 {
//            var prompts = String()
//            detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
//                prompts.append("\(prompt), ")
//            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
            
            cell.activityLabel.text = activityArray[indexPath.row]
            cell.promptLabel.text = "Prompt: " + promptArray[indexPath.row]
            cell.mediaLabel.text = "Media: " + mediaArray[indexPath.row]
                   
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as!  NotesTableViewCell
            cell.notesLabel.text = notes[indexPath.row]
            
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showViewDetailReport", sender: indexPath.row)
        }
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier == "showViewDetailReport" {
//               let destination = segue.destination as? ViewDetailReportViewController
//               let row = sender as! Int
//               var prompts = String()
//               detailActivity[row].activityPrompt .forEach { (prompt) in
//                   prompts.append("\(prompt), ")
//               }
//
//               destination?.activity = detailActivity[row].activityTitle
//               destination?.howTo = detailActivity[row].activityDesc
//               destination?.prompt = prompts
//               print(prompts)
//               destination?.media = detailActivity[row].activityMedia
//               destination?.tips  = detailActivity[row].activityTips
//               destination?.skill = detailActivity[row].skillTitle.recordID
//               destination?.program = CKRecord.ID(recordName: detailActivity[row].baseProgramTitle)
//           }
//       }
    
}
