//
//  TodayViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit

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
    
    var parentNotes : String?
    var therapySession = [TherapySessionModel]()
    var detailActivity = [DetailedReportModel]()
    var therapyNotes = String()
    var therapyRecordID = CKRecord.ID()
    var fileName: String = "audioFile.m4a"
    var audioData = Data()
    var audioFilename = URL(string: "")
    var audioPlayer: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getActivitySession()
        
        audioAttachmentButton.isEnabled = false
        imageAttachmentImageView.isHidden = true
        
        let recordingPlay = UIImage(named: "Recordings Play")?.withRenderingMode(.alwaysOriginal)
        audioAttachmentButton.setImage(recordingPlay, for: .normal)
        
        //Looks for single or multiple taps.
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

//        view.addGestureRecognizer(tap)
        
        feedbackTextView.text = "Write your notes about today's activity"
        feedbackTextView.textColor = UIColor.lightGray
//        feedbackTextView.becomeFirstResponder()
        feedbackTextView.delegate = self // agar fungsi check changed dan placeholdernya nyala, harus di delegasikan ke UIVC
        feedbackTextView.selectedTextRange = feedbackTextView.textRange(from: feedbackTextView.beginningOfDocument, to: feedbackTextView.beginningOfDocument)
        feedbackTextView.doneButton(title: "Done", target: self, selector: #selector(dismissKeyboard(sender:)))
        
        // notif for view if keyboard will show or hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // MARK: - Styling
        submitButton.layer.cornerRadius = 24
        
        feedbackTextView.backgroundColor = .white
        feedbackTextView.layer.cornerRadius = 4
        feedbackTextView.layer.borderWidth = 0.5
        feedbackTextView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        
        
    }
    
    @objc func dismissKeyboard(sender: Any) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func getActivitySession(){
        let reloadGroup = DispatchGroup()
        
        reloadGroup.enter()
        TherapySessionManager.getTherapySession { (arrayOfTherapySession) in
            self.therapySession = arrayOfTherapySession
            self.therapyNotes = arrayOfTherapySession[0].therapySessionNotes
            self.therapyRecordID = arrayOfTherapySession[0].therapySessionRecordID
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEEE, d MMM yyyy"
//            DispatchQueue.main.async {
//                self.todayDateLabel.text = "Activities on \(formatter.string(from: arrayOfTherapySession[0].therapySessionDate))" // diganti date dari Data
//            }
            
            reloadGroup.leave()
        }
        
        
        reloadGroup.notify(queue: .main){
            DetailedReportDataManager.getDetailedTherapySession(therapySessionRecordID: self.therapyRecordID) { (activityRecordsID) in
                DetailedReportDataManager.getDetailedActivity(activityRecordID: activityRecordsID) { (DetailActivitiesData) in
                    self.detailActivity = DetailActivitiesData
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }

            DetailedReportDataManager.getAudio(therapySessionRecordID: self.therapyRecordID) { (audioNSURL) in
                self.setupPlayer(audioNSURL: audioNSURL)
                self.audioAttachmentButton.isEnabled = true
            }

            DetailedReportDataManager.getPhoto(therapySessionRecordID: self.therapyRecordID) { (imagePhoto) in
                guard let photo = imagePhoto as? UIImage else {
                    return
                }
                self.imageAttachmentImageView.image = photo
                self.imageAttachmentImageView.isHidden = false
            }
        }
    }
    
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

        
        if let parentNotes = parentNotes {
            if parentNotes != "" {
                ParentFeedbackManager.saveFeedback(parentNotes: parentNotes, therapySessionRecordID: therapyRecordID) { (ParentNotesModel, parentNotesRecordID) in
                    print(parentNotesRecordID)
                    let alertController = UIAlertController(title: "Feedback Saved", message: "Your feedback successfully saved, press OK to continue.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            print("not saved")
            let alertController = UIAlertController(title: "Cannot saved feedback", message: "Please try again, press OK to continue.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        //jadi nanti number of row in section untuk notes nya nambah datanya
        //setelahnya textviewnya kosong
        
    }
    

}

// MARK: - Delegate and Data Source
extension TodayViewController: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
// MARK: - Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.systemFont(ofSize: 13)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = .gray

        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
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
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMM yyyy"
            return "Activities on \(formatter.string(from: Date()))"
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
            return detailActivity.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            var prompts = String()
            detailActivity[indexPath.row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityListCell", for: indexPath) as! ActivityListTableViewCell
            
            cell.activityLabel.text = detailActivity[indexPath.row].activityTitle
            cell.promptLabel.text = "Prompt: " + prompts
            cell.mediaLabel.text = "Media: " + detailActivity[indexPath.row].activityMedia
            return  cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesListCell", for: indexPath) as!  NotesListTableViewCell
            if therapyNotes == ""{
                cell.notesLabel.text = "There's no note from the therapist"
            } else {
                cell.notesLabel.text = therapyNotes
            }
            
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showActivityDetail", sender: indexPath.row)
        }
    }
    
    // untuk get notesnya
    func textViewDidChange(_ textView: UITextView) {
        self.parentNotes = textView.text
        print(parentNotes)
    }
    
    // untuk placeholdernya
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray && textView.text != nil{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            textView.text = "Let the therapist know what's in your thought"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
// MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivityDetail" {
            let destination = segue.destination as? ActivicityDetailViewController
            let row = sender as! Int
            var prompts = String()
            detailActivity[row].activityPrompt .forEach { (prompt) in
                prompts.append("\(prompt), ")
            }

            destination?.activity = detailActivity[row].activityTitle
            destination?.howTo = detailActivity[row].activityDesc
            destination?.prompt = prompts
            print(prompts)
            destination?.media = detailActivity[row].activityMedia
            destination?.tips  = detailActivity[row].activityTips
            destination?.skill = detailActivity[row].skillTitle.recordID
            destination?.program = CKRecord.ID(recordName: detailActivity[row].baseProgramTitle)
        }
    }
}

extension UITextView{
    // add Done button for textView
    func doneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

extension UITextField{
    // add Done button for textView
    func doneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
