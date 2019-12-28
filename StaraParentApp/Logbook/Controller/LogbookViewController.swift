//
//  LogbookViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import CloudKit

class LogbookViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    // MARK: - Properties
//    let therapistSession = ["Fri, 18 Oct 2019",  "Wed, 16 Oct 2019", "Mon, 14 Oct 2019", "Fri, 11 Oct 2019"]
//    let parentSession = ["Thu, 17 Oct 2019", "Tue, 15 Oct 2019"]
    
    
//    var studentRecordID = String()
    var therapySession = [TherapySessionModel]()
    var parentsNotes = [ParentNotesModel]()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(populateTableView), for: .valueChanged)
        populateTableView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentedTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    // MARK: - Model [George]
    
    @objc func populateTableView(){
        let reloadGroup = DispatchGroup()
        
        reloadGroup.enter()
        TherapySessionManager.getTherapySession { (arrayOfTherapySession) in
            self.therapySession = arrayOfTherapySession
            let therapySessionID = self.therapySession.map{$0.therapySessionRecordID}
            if therapySessionID.count > 0{
                reloadGroup.enter()
                ParentNotesManager.getParentNotes(therapySessionID: therapySessionID) { (arrayOfParentNotes) in
                    self.parentsNotes = arrayOfParentNotes
                    reloadGroup.leave()
                }
            } else {
                print("No data")
            }
            reloadGroup.leave()
        }
        
        reloadGroup.notify(queue: .main){
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
        
    }
    
    func emptyState(){
        let footer = UIView()
        let emptyStateImage = UIImageView()
        emptyStateImage.image = UIImage(named: "Search not found")
        emptyStateImage.frame = CGRect(x: 0, y: 0, width: 296, height: 284)
        footer.addSubview(emptyStateImage)

        emptyStateImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateImage.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            emptyStateImage.topAnchor.constraint(equalTo: footer.topAnchor, constant: 8)
        ])
        
        DispatchQueue.main.async {
            self.tableView.tableFooterView = footer
        }
    }
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
//            if parentsNotes.count == 0 {
//                emptyState()
//            }
            return parentsNotes.count
        case 1:
            return therapySession.count
            
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logbookCell", for: indexPath) as! LogbookTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy, HH:mm a"
//
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let parentNotesDate = formatter.string(from: parentsNotes[indexPath.row].parentNoteDay)
            cell.logbookLabel.text = parentNotesDate
            
        case 1:
            let therapySessionDate = formatter.string(from: therapySession[indexPath.row].therapySessionDate)
            cell.logbookLabel.text = therapySessionDate
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
    
    
    // MARK: - Segue [George]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTherapistDetail" {
            let destination = segue.destination as? TherapistDetailViewController
            let row = sender as! Int
            destination?.therapySessionRecordID = therapySession[row].therapySessionRecordID
            destination?.therapySessionNotes = therapySession[row].therapySessionNotes
            destination?.therapySessionDate = therapySession[row].therapySessionDate
       } else if segue.identifier == "showParentsDetail" {
           let destination = segue.destination as? ParentsDetailViewController
           let row = sender as! Int
           destination?.parentNote = parentsNotes[row].parentNoteContent
           destination?.parentNoteDate = parentsNotes[row].parentNoteDay
       }
   }
    
    
}
