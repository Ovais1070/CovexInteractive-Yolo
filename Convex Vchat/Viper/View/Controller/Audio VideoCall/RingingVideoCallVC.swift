//
//  RingingVideoCallVC.swift
//  ConvexVchat
//
//  Created by Ovais Naveed on 8/12/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class RingingVideoCallVC: UIViewController {
    
          
            @IBOutlet weak var callerVideoView: UIView!
            @IBOutlet weak var clientPic: UIImageView!
            @IBOutlet weak var callRingingBtn: UIButton!
            @IBOutlet weak var name: UILabel!
    
        
            var clientName: String = ""
            var clientNumber: String = ""
        
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = GlobaColor.shared.color
        }
             override func viewDidLoad() {
                 super.viewDidLoad()
                 navigationController?.navigationBar.isTranslucent = false
                navigationController?.navigationBar.barTintColor = nil
                 let screenRect = UIScreen.main.bounds
                 let screenWidth = screenRect.size.width
                 if screenWidth <= 375{
                     print("YES")
                 
                 clientPic.makeCircular()
                     
                 } else {
                 
                 clientPic.makeCircular2()
                 
                 }
                 
                 clientPic.layer.borderWidth = 2
                 clientPic.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                 callRingingBtn.makeCircular()
                 
                self.name.text = clientName

                 
                 if self.navigationController == nil {
                     return
                 }

                 // Create a navView to add to the navigation bar
                 let navView = UIView()

                 // Create the label
                 let label = UILabel()
                 label.text = "Video Call"
                 label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                 label.sizeToFit()
                 label.center = navView.center
                 label.textAlignment = NSTextAlignment.center

                 // Create the image view
                 let image = UIImageView()
                 image.image = UIImage(named: "videocam-1")
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
         
         
         
         
         
         @IBAction func flipCamera(_ sender: Any) {
             print("Flip Camera")
         }
         
         @IBAction func videoOffBtn(_ sender: Any) {
             print("Video turn on request")
         }
         
         @IBAction func muteBtn(_ sender: Any) {
             print("Audio muted")
         }
         
         


    
    
    
    
    
    
    
}
