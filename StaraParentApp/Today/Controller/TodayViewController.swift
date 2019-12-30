//
//  TodayViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class TodayViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var attachmentsView: UIView!
    
    @IBOutlet weak var todayDateLabel: UILabel!
    
    @IBOutlet weak var audioAttachmentButton: UIButton!
    @IBOutlet weak var imageAttachmentImageView: UIImageView!
    
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    let activityListArray = ["Stomp Feet", "Bear Hug"]
    let promptListArray = ["Visual", "Gesture"]
    let mediaListArray = ["Ground", "-"]
    let notesArray = ["Molly was doing good on Stomp Feet activity today, but still need guidance on doing it. If Molly starts crying while doing the Stompt Feet activity please give her a Bear Hug. Good job Molly, see you on Wednesday :)"]
    
    
    var fileName: String = "audioFile.m4a"
    var audioData = Data()
    var audioFilename = URL(string: "")
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioAttachmentButton.isEnabled = false
        imageAttachmentImageView.isHidden = true
        
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
        
    }
    
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
    //            DetailedReportDataManager.getAudio(therapySessionRecordID: therapySessionRecordID) { (audioNSURL) in
    //                self.setupPlayer(audioNSURL: audioNSURL)
                self.audioPlayer.play()
                self.audioAttachmentButton.setImage(recordingPause, for: .normal)
    //            }
            } else {
                audioPlayer.stop()
                audioAttachmentButton.setTitle("Play", for: .normal)
                audioAttachmentButton.setImage(recordingPlay, for: .normal)
                    
            }
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        //disini ga perform segue
        //ambil value dari textview dulu
        //nanti dia send value ke parents report
        //jadi nanti number of row in section untuk notes nya nambah datanya
        //setelahnya textviewnya kosong
        
    }
    

}

// MARK: - Delegate and Data Source
extension TodayViewController: UITableViewDataSource, UITableViewDelegate {
    
// MARK: - Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "Notes"
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
    
// MARK: - Cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activityListArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
//            var prompts = String()
//            detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
//                prompts.append("\(prompt), ")
//            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityListCell", for: indexPath) as! ActivityListTableViewCell
            
            cell.activityLabel.text = activityListArray[indexPath.row]
            cell.promptLabel.text = "Prompt: " + promptListArray[indexPath.row]
            cell.mediaLabel.text = "Media: " + mediaListArray[indexPath.row]
        
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesListCell", for: indexPath) as!  NotesListTableViewCell
            
            cell.notesLabel.text = notesArray[indexPath.row]
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showActivityDetail", sender: self)
        }
    }
    
    
// MARK: - Prepare for Segue
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

}

