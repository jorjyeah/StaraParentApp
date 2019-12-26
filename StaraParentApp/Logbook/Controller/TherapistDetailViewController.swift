//
//  TherapistDetailViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit

class TherapistDetailViewController: UIViewController, AVAudioPlayerDelegate {
    
// MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
// MARK: - IBOutlet UIView
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var audioAttachmentButton: UIButton!
    @IBOutlet weak var imageAttachment: UIImageView!
    

// MARK: - Properties
    let activityArray = ["Stomp Feet", "Bear Hug"]
    let promptArray = ["Gesture", "Verbal"]
    let mediaArray = ["Ground", "-"]
    let notes = ["Molly was crying while doing the stomp feet today. If Molly starts crying again while doing it, plese don't force her to do it."]
    
//    var detailActivity = [DetailedReportCKModel]()
//    var therapySessionRecordID = CKRecord.ID()
//    var therapySessionNotes = String()
//    var therapySessionDate = Date()
    
    
// MARK: - Audio Properties
    var fileName: String = "audioFile.m4a"
    var audioData = Data()
    var audioFilename = URL(string: "")
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        getActivitySession()
        
        audioAttachmentButton.isEnabled = false
        imageAttachment.isHidden = true
        
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
        attachmentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }
    
    
// MARK: - Model [George]
//    func getActivitySession(){
//        print(therapySessionNotes)
//        DetailedReportDataManager.getDetailedTherapySession(therapySessionRecordID: therapySessionRecordID) { (activityRecordsID) in
//            DetailedReportDataManager.getDetailedActivity(activityRecordID: activityRecordsID) { (DetailActivitiesData) in
//                self.detailActivity = DetailActivitiesData
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//
//        DetailedReportDataManager.getAudio(therapySessionRecordID: therapySessionRecordID) { (audioNSURL) in
//            if audioNSURL != nil{
//                self.setupPlayer(audioNSURL: audioNSURL)
//                self.audioAttachmentButton.isEnabled = true
//            }
//        }
//
//        DetailedReportDataManager.getPhoto(therapySessionRecordID: therapySessionRecordID) { (imagePhoto) in
//            guard let photo = imagePhoto as? UIImage else {
//                return
//            }
//            self.imageAttachment.image = photo
//            self.imageAttachment.isHidden = false
//        }
//    }
    
    
    
// MARK: - Play and Pause Audio
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupPlayer(audioNSURL : NSURL){
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: audioNSURL as URL)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        
        audioAttachmentButton.setTitle("Play", for: .normal)
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
    }
    
    
    @IBAction func playAct(_ sender: Any) {
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        let recordingPause = UIImage(named: "Recordings Pause")?.withRenderingMode(.alwaysOriginal)
                
        if audioAttachmentButton.titleLabel?.text == "Play" {
            audioAttachmentButton.setTitle("Stop", for: .normal)
            //Ini George yg komen sendiri
            //            DetailedReportDataManager.getAudio(therapySessionRecordID: therapySessionRecordID) { (audioNSURL) in
            //                self.setupPlayer(audioNSURL: audioNSURL)
            self.audioPlayer.play()
            self.audioAttachmentButton.setImage(recordingPause, for: .normal)
        } else {
            audioPlayer.stop()
            audioAttachmentButton.setTitle("Play", for: .normal)
                    //playButton.setImage(UIImage(named: "Recordings Play"), for: .normal)
            audioAttachmentButton.setImage(recordingPlay, for: .normal)
                
        }
    }
    

}



// MARK: - Extension
extension TherapistDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
// MARK: - Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 13)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = .gray

        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        headerView.addSubview(myLabel)

        return headerView
    }
    
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
    
// MARK: - Cell
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
    
    
// MARK: - Prepare for Segue
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
