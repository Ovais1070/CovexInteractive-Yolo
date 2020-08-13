//
//  LaunchVC.swift
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    
    //MARK:-  Local Variable
    
    var presenter: PostPresenterInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- PostViewProtocol

extension LaunchVC : PostViewProtocol {
    func getUserVerData(api: Base, data: VerifyUser?) {
        
    }
    
//    
    func onError(api: Base, message: String, statusCode code: Int) {
        
    }
    func success(api: Base, data: VerifyUser?) {
        
        
        
        
    }
    
    
//    func getProfile(api: Base, data: Profile?) {
//        Common.storeUserData(from: data)
//        storeInUserDefaults()
//    }
    
}
