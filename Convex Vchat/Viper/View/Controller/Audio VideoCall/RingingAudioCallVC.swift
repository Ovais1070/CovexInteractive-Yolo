//
//  RingingAudioCallVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class RingingAudioCallVC: UIViewController {

      
         @IBOutlet weak var bgVu1: UIView!
         @IBOutlet weak var incomPic: UIImageView!
         
         @IBOutlet weak var callRingingBtn: UIButton!
      
         
         
         
         
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
             callRingingBtn.makeCircular()
             
             
             
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
         

     
     @IBAction func callRingingBtn(_ sender: Any) {
         print("Call end button pressed")
     }
     
     
     
     
     
     @IBAction func addCallerBtn(_ sender: Any) {
         print("Caller added")
     }
     
     @IBAction func videoOnBtn(_ sender: Any) {
         print("Video turn on request")
     }
     
     @IBAction func muteBtn(_ sender: Any) {
         print("Audio muted")
     }
     
     


}
