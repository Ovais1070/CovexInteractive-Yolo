//
//  IncomAudioVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class IncomAudioVC: UIViewController {

    
    @IBOutlet weak var bgVu1: UIView!
    @IBOutlet weak var incomPic: UIImageView!
    @IBOutlet weak var callEndBtn: UIButton!
    @IBOutlet weak var callPickBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        if screenWidth <= 375{
            print("YES")
        bgVu1.makeCircular()
        incomPic.makeCircular()
            
        } else {
        bgVu1.makeCircular2()
        incomPic.makeCircular2()
        
        }
        
        incomPic.layer.borderWidth = 4
        incomPic.layer.borderColor = #colorLiteral(red: 0.4576725364, green: 0, blue: 0.8449745774, alpha: 1)
        callEndBtn.makeCircular()
        callPickBtn.makeCircular()
        
        
//        let image : UIImage = UIImage(named: "callLogoNavigation")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        navigationItem.titleView = imageView
//        self.navigationItem.title = "Edit Profile"
        
        
        if self.navigationController == nil {
            return
        }

        // Create a navView to add to the navigation bar
        let navView = UIView()

        // Create the label
        let label = UILabel()
        label.text = "Audio Call"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center

        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: "callLogoNavigation")
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit

        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)

        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView

        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
         
    }
    

    
    
    
    
    @IBAction func callPickBtn(_ sender: Any) {
        
        print("Call picked")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "OnAudioCallVC") as! OnAudioCallVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func callEndBtn(_ sender: Any) {
        print("call ended")
    }
    
    

}




