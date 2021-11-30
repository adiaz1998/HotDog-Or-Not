//
//  ViewController.swift
//  HotDog Or Not
//
//  Created by Alan Díaz on 11/29/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    // Delegation design pattern -> Text Field: Properties
    
    // Steps to implement a delegate:
    // 1. Create an object
    
    let imagePicker = UIImagePickerController()
    
    let results = [VNClassificationObservation]()
    //[0.8, 0.4, 0.3] -> 0.8 -> hotDog
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. Initliaze the delegate in View Did load
        imagePicker.delegate = self
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
    }
    
    func detect(){
        ßßßß
    }
    
}

