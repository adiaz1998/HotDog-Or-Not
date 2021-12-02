//
//  ViewController.swift
//  HotDog Or Not
//
//  Created by Alan Díaz on 11/29/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Delegation design pattern -> Text Field: Properties
    
    // Steps to implement a delegate:
    // 1. Create an object
    
    let imagePicker = UIImagePickerController()
    
    let result = [VNClassificationObservation]()
    //[0.8, 0.4, 0.3] -> 0.8 -> hotDog
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. Initliaze the delegate in View Did load
        imagePicker.delegate = self
        // Do  any additional setup after loading the view
    
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //1. Select the image
        //2. conver this image from UImage data type into CImage
        //3. Detect (CImage)
        if let image = info[.originalImage] as? UIImage {
            
            //Display the selected image on the screen
            imageView.image = image
            
            //Diismiss imagePicker after capturing the image
            imagePicker.dismiss(animated : true, completion : nil)
            
            //2. Convert this image from UIImage data type into CIImage
            
            guard let ciImage = CIImage(image : image) else {return}
            
            //3. Detect (CIImage)
            detect(image: ciImage)
        }
        
        
        
        
    }
    
    // Detect function:
    // 1. Model
    // 2. Request
    // 3. Result
    
    
    func detect(image : CIImage){
        // Initiliaze the Model
            
        if let model = try? VNCoreMLModel(for : Inceptionv3__1_().model){
            
            //Request the result
            
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                
            // Results -> (0.8, 0.7, 0.3) -> 0.8: Hot Dog
                guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else { return }
                
                if topResult.identifier.contains("hotdog"){
                    // Main Thread - | | | |  | | |
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Hotdog"
                    }
                    
                }
                
                else {
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Not Hotdog"
                    }
                    
                }
            
            })
            
            // Handler
            let handler = VNImageRequestHandler(ciImage: image)
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
            
        
        }
    }
    
}
