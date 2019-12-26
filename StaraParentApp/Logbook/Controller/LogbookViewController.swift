//
//  LogbookViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class LogbookViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    // MARK: - Properties
    let therapistSession = ["Fri, 18 Oct 2019",  "Wed, 16 Oct 2019", "Mon, 14 Oct 2019", "Fri, 11 Oct 2019"]
    let parentSession = ["Thu, 17 Oct 2019", "Tue, 15 Oct 2019"]
    
    
//    var studentRecordID = String()
//    var therapySession = [TherapySessionCKModel]()
//    var parentsNotesData = [ParentNotesCKModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        populateTableView()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentedTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    // MARK: - Model [George]
    
//     func populateTableView(){
//            //navigationController?.navigationBar.prefersLargeTitles = false
//            let therapySessionsData = TherapySessionCKModel.self
//            therapySessionsData.getTherapySession(studentRecordID: studentRecordID) { therapySessionsData in
//                self.therapySession = therapySessionsData
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//
//
//            DetailedParentNotesDataManager.getParentNotes(studentRecordID: studentRecordID) {
//                parentsNotesData
//                in
//                self.parentsNotesData = parentsNotesData
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//
//
//        @IBAction func unwindFromSummary(_ sender:UIStoryboardSegue){
//            // bikin function dulu buat unwind, nanti di exit di page summary
//            if sender.source is SummaryViewController{
//                if let senderVC = sender.source as? SummaryViewController{
//                    populateTableView()
//    //                DispatchQueue.main.async {
//    //                    self.tableView.reloadData()
//    //                }
//
//    //                print(senderVC.test)
//                    print(senderVC.selectedActivity)
//                }
//            }
//        }
//    }
    


}

extension LogbookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return parentSession.count
            
        case 1:
            return therapistSession.count
            
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logbookCell", for: indexPath) as! LogbookTableViewCell
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, d MMM yyyy, HH:mm a"
//
        switch segmentedControl.selectedSegmentIndex {
        case 0:
//            let parentNotesDate = formatter.string(from: parentsNotesData[indexPath.row].parentNoteDay)
            cell.logbookLabel.text = parentSession[indexPath.row]
            
        case 1:
//            let therapySessionDate = formatter.string(from: therapySession[indexPath.row].therapySessionDate)
            cell.logbookLabel.text = therapistSession[indexPath.row]
            
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "showParentsDetail", sender: indexPath.row)
        case 1:
            performSegue(withIdentifier: "showTherapistDetail", sender: indexPath.row)
        default:
            break
        }
    }
    
    
    // MARK: - Model [George]
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier == "showAddReport" {
//               let destination = segue.destination as! AddReportViewController
//               destination.studentRecordID = studentRecordID
//               print("\(destination.studentRecordID)")
//           } else if segue.identifier == "showTherapistDetail" {
//               let destination = segue.destination as? DetailTherapistReportViewController
//               let row = sender as! Int
//               destination?.therapySessionRecordID = therapySession[row].therapySessionRecordID
//               destination?.therapySessionNotes = therapySession[row].therapySessionNotes
//               destination?.therapySessionDate = therapySession[row].therapySessionDate
//           } else if segue.identifier == "showParentsDetail" {
//               let destination = segue.destination as? ParentsDetailViewController
//               let row = sender as! Int
//               destination?.parentNote = parentsNotesData[row].parentNoteContent
//               destination?.parentNoteDate = parentsNotesData[row].parentNoteDay
//           }
//       }
    
    
}
