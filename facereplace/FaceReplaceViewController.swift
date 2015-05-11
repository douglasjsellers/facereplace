//
//  FaceReplaceViewController.swift
//  facereplace
//
//  Created by DOUGLAS SELLERS on 5/7/15.
//  Copyright (c) 2015 Douglas Sellers. All rights reserved.
//

import UIKit

class FaceReplaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var mainImage: UIImageView!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        printLocationOfPicturesDirectory()
        findFaceInBaseImage( mainImage.image!)
    }
    


    func printLocationOfPicturesDirectory()
    {
        #if arch(i386) || arch(x86_64)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
            NSLog("Document Path: %@", documentsPath)
        #endif
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseImageToUpload(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
        {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        

    }
    
    func findFaceInBaseImage(image:UIImage)
    {
        let ciImage:CIImage = CIImage(image: image)
        let context:CIContext = CIContext(options:nil)
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let features:NSArray = [detector.featuresInImage(ciImage)]
        for subArray in features
        {
            for f in subArray as! NSArray
            {
                let face:CIFaceFeature = f as! CIFaceFeature
                NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y, face.bounds.width, face.bounds.height);
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage;
        self.findFaceInBaseImage(image)

    }


}
