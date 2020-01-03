//
//  AddTherapistViewController.swift
//  StaraParentApp
//
//  Created by Ni Wayan Bianka Aristania on 29/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class AddTherapistViewController: UIViewController {

    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var qrCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQRCode()
        changeName()
        // Do any additional setup after loading the view.
    }
    
    func changeName(){
        guard let childName : String = UserDefaults.standard.string(forKey: "selectedStudentName") else {
            return
        }
        
        self.childName.text = childName
    }
    func generateQRCode(){
        guard let childUID : String = UserDefaults.standard.string(forKey: "selectedStudent") else {
            return
        }
        
        
        // Generate QrCode
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        let qrData = childUID.data(using: String.Encoding.ascii)
        qrFilter.setValue(qrData, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage else { return }
        // Scaling
        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        let scaledQrImage = qrImage.transformed(by: qrTransform)
        
        // Get a CIContext - processing CIImage
        let context = CIContext()
        // Create a CGImage *from the extent of the outputCIImage*
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        // Finally, get a usable UIImage from the CGImage
        let processedImage = UIImage(cgImage: cgImage)
        qrCode.image = processedImage
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
