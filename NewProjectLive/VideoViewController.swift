//
//  VideoViewController.swift
//  NewProjectLive
//
//  Created by Anil Kumar on 13/06/17.
//  Copyright © 2017 Atti. All rights reserved.
//

import UIKit
import TesseractOCR

class VideoViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,G8TesseractDelegate {

    @IBOutlet var txt: UITextView!
    @IBOutlet var img: UIImageView!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camera(_ sender: UIButton) {
    }

    @IBAction func PickImage(_ sender: UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img.contentMode = .scaleAspectFit
            img.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        img.image = selectedPhoto
        
        
        dismiss(animated: true, completion: {
            self.performImageRecognition(selectedPhoto)
        })
    }

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func performImageRecognition(_ image: UIImage) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let tesseract:G8Tesseract = G8Tesseract(language:"eng");
            //tesseract.language = "eng+ita";
            tesseract.delegate = self;
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize();
            DispatchQueue.main.async {
                self.txt.text = tesseract.recognizedText

            }

        }
    }
}

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


