//
//  TodayViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 26/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class TodayViewController: StaraUIViewController {

    override func viewDidLoad() {
        if UserDefaults.standard.bool(forKey: "didPreloadData") == false {
            NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name("preloadDataDone"), object: nil)
        } else {
            loadData()
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func loadData(){
        print("done")
        DispatchQueue.main.async {
            self.startLoading()
        }
//        let reloadGroup = DispatchGroup()
//        let studentsData = StudentCKModel.self
//        reloadGroup.enter()
//        studentsData.getTherapySchedule{ studentsRecordID in
//            if studentsRecordID.count != 0{
//                print("studentsRecordID:\(studentsRecordID)")
//                reloadGroup.enter()
//                studentsData.getStudentData(studentsRecordID: studentsRecordID) { studentsData in
//                    self.student = studentsData // tampung data semua
//                    self.filteredData = studentsData // tampung data yang terfilter
//                    reloadGroup.leave()
//                }
//                reloadGroup.leave()
//            }
//            else {
//                reloadGroup.leave()
//            }
//        }
        
//        reloadGroup.notify(queue: .main){
//            self.tableView.reloadData()
//            self.dismissLoading()
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
