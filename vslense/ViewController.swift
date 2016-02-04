//
//  ViewController.swift
//  vslense
//
//  Created by Huy Nguyen on 2/4/16.
//  Copyright © 2016 Huy Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker:UIImagePickerController!

    @IBOutlet weak var currentImageView: UIImageView!
    
    @IBAction func didPressCameraPreview() {
        print("camera preview")
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func didPressPhotoLibraryPicker(){
        print("photo lib")
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        currentImageView.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        let cgimg = currentImageView.image?.CGImage
        let pex = PixelExtractor.init(img: cgimg!)
        print("image size is \(pex.height) x \(pex.width)")

//        let uncasted_data = CGBitmapContextGetData(pex.context)
//        let data = UnsafePointer<UInt8>(uncasted_data)
//        for y in 0..<pex.height {
//            for x in 0..<pex.width {
//                print(y,",",x)
//            }
//        }

        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

