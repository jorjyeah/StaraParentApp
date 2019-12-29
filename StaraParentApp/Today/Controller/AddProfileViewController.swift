//
//  AddProfileViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class AddProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    // MARK: - Properties
//   var newProfilePicture = UIImage(named: "Student Photo Default")
//    let therapistData = ProfileTherapistCKModel.self
//    var imagePicker: ImagePicker!
//    var newData = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//        populateProfileTherapist()
//
//        nameTextField.delegate = self
//        institutionTextField.delegate = self
//        addressTextField.delegate = self
    }
    
    @IBAction func addPictureTapped(_ sender: Any) {
//        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
//        let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
//            newData.append(String(nameTextField.text!))
//            newData.append(String(institutionTextField.text!))
//            newData.append(String(addressTextField.text!))
//            ProfileTherapistCKModel.getTherapistData(userRef:therapistRecordID) { profileData in
//                SaveEditedProfile.saveProfile(newData: self.newData, newProfilePicture: self.newProfilePicture!, profileData: profileData.therapistRecordID) { (success) in
//                    if success {
//                        self.performSegue(withIdentifier: "backToProfile", sender: nil)
//                    }
//            }
        }
    
//    func populateProfileTherapist(){
//            let theraphistData = ProfileTherapistCKModel.self
//            let therapistRecordID = String(UserDefaults.standard.string(forKey: "userID")!)
//            let therapistName = String(UserDefaults.standard.string(forKey: "therapistName")!)
//
//            theraphistData.checkTherapistData(userRef: therapistRecordID) { (available) in
//                if available{
//                    theraphistData.getTherapistData(userRef: therapistRecordID) { (ProfileTherapistData) in
//                        DispatchQueue.main.async {
//                            self.nameTextField.text = ProfileTherapistData.therapistName
//                            self.profileImageVIew.image = ProfileTherapistData.therapistPhoto
//
//                            if ProfileTherapistData.institutionName == "no data" {
//                                self.institutionTextField.placeholder = "Institution name hasn't been set yet"
//                            } else {
//                                self.institutionTextField.text = ProfileTherapistData.institutionName
//                            }
//
//                            if ProfileTherapistData.therapistAddress == "no data" {
//                                self.addressTextField.placeholder = "Address hasn't been set yet"
//                            } else {
//                                self.addressTextField.text = ProfileTherapistData.therapistAddress
//                            }
//                        }
//                    }
//                } else {
//                    print("no data")
//                    self.nameTextField.text = therapistName
//                    //self.profileImageVIew.image = UIImage(named: "Student Photo Default")!
//                    self.institutionTextField.placeholder = "Institution name hasn't been set yet"
//                    self.addressTextField.placeholder = "Address hasn't been set yet"
//                }
//            }
//        }
    }
    



//extension EditProfileViewController : ImagePickerDelegate, UITextFieldDelegate {
//    func didSelect(image: UIImage?) {
//        self.profileImageVIew.image = image
//        newProfilePicture = (image ?? UIImage(named: "Student Photo Default"))!
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool {
//
//
//        if textField == nameTextField {
//            let maxLength = 20
//
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        } else if textField == institutionTextField {
//            let maxLength = 25
//
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        } else {
//            let maxLength = 50
//
//            let currentString: NSString = textField.text! as NSString
//            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
//
//    }
//}

