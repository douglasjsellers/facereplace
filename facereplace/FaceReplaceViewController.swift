//
//  FaceReplaceViewController.swift
//  facereplace
//
//  Created by DOUGLAS SELLERS on 5/7/15.
//  Copyright (c) 2015 Douglas Sellers. All rights reserved.
//

import UIKit

class FaceReplaceViewController: UIViewController
{
    @IBOutlet weak var mainImage: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        findFaceInBaseImage()
    }
    


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findFaceInBaseImage()
    {
        let context:CIContext = CIContext(options:nil)
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let features:NSArray = [detector.featuresInImage(CIImage(image: mainImage.image))]
        for subArray in features
        {
            for f in subArray as! NSArray
            {
                let face:CIFaceFeature = f as! CIFaceFeature
                NSLog("Face found at (%f,%f) of dimensions %fx%f", face.bounds.origin.x, face.bounds.origin.y, face.bounds.width, face.bounds.height);
            }
        }
    }
    


}
