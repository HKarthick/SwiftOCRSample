//
//  OCRViewController.swift
//  NewProjectLive
//
//  Created by Anil Kumar on 13/06/17.
//  Copyright © 2017 Atti. All rights reserved.
//

import UIKit
import TesseractOCR


class OCRViewController: UIViewController ,G8TesseractDelegate{
    @IBOutlet var imagewithtext: UIImageView!
    @IBOutlet var textview: UITextView!
    @IBOutlet var textfromimageOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func TextfromImage(_ sender: UIButton) {
        
        let tesseract:G8Tesseract = G8Tesseract(language:"eng");
        //tesseract.language = "eng+ita";
        tesseract.delegate = self;
        tesseract.image = UIImage(named: "image_sample1.jpg");
        tesseract.recognize();
        textview.text = tesseract.recognizedText
        
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
