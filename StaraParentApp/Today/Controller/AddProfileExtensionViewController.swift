//
//  AddProfileExtensionViewController.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 08/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit

extension AddProfileViewController : UITextFieldDelegate{
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        activeTextField = textField
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        activeTextField = nil
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//            pushView(notification: notification as Notification, view: self.view)
//        }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
//
//    func pushView(notification : Notification, view:UIView){
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//
//        let keyboardFrame = keyboardSize.cgRectValue
//        let yPos = height - keyboardFrame.height
//
//        let targetField = activeTextField?.convert((activeTextField?.frame.origin)!, to: view)
//        let activeTextFrameSize = (activeTextField?.frame.size.height)! as CGFloat
//
//        guard let target = targetField?.y else {return}
//        guard let active : CGFloat = activeTextFrameSize as CGFloat else {return}
//        let yLastPosition = target + active
//
//        if view.frame.origin.y == 0 && yLastPosition > yPos{
//            view.frame.origin.y -= (yLastPosition - yPos + 8)
//        }
//    }
}
