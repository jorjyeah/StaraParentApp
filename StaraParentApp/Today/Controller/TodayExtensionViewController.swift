//
//  TodayExtensionViewController.swift
//  StaraParentApp
//
//  Created by George Joseph Kristian on 08/01/20.
//  Copyright © 2020 George Joseph Kristian. All rights reserved.
//

import UIKit

extension TodayViewController{
    // configure position UIView for keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}

        let keyboardFrame = self.view.convert(keyboardSize.cgRectValue, to: view.window)

        view.frame.origin.y = -keyboardFrame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
