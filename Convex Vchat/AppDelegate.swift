//
//  AppDelegate.swift
//  SimpleWebRTC
//
//  Created by n0 on 2019/01/05.
//  Copyright © 2019年 n0. All rights reserved.
//

import UIKit
import CoreData
import Starscream
import WebRTC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //    var socket: WebSocket!
    //    var tryToConnectWebSocket: Timer!
    //    var webRTCClient: WebRTCClient!
    //    var service = CustomSocket()
    var socket: SocketClient?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = Router.setWireFrame()
        window?.becomeKey()
        window?.makeKeyAndVisible()
        
        socket = SocketClient.instance()
        socket?.connect()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCallingViewController(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        //        socket = WebSocket(url: URL(string: socketUrl)!)
        //        socket.delegate = self
        //
        //        tryToConnectWebSocket = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
        //            if self.socket.isConnected {
        //                return
        //            }
        //        self.socket.connect()
        //    })
        
        
        
        
        
        
        //   NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
    
    // MARK: - Core Data stack
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        let container = NSPersistentContainer(name: "ContactsModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @objc func showCallingViewController(notification: Notification) {
        let rootViewController = self.window?.rootViewController as! UINavigationController
        let data = notification.object as? [String: Any]
        let detail = data?["data"] as? [String: Any]
        //
        
        
        print("detaildetail",detail)
        let info = CallingInfoData(
            firstName: detail?["first_name"] as? String ?? "",
            lastName: detail?["last_name"] as? String ?? "",
            username: detail?["username"] as? String ?? "",
            profilePicture: detail?["profile_pic"] as? String ?? "",
            email: detail?["email"] as? String ?? "",
            mobile: detail?["mobile"] as? String ?? "",
            address: detail?["address"] as? String ?? "",
            deviceId: detail?["device_id"] as? String ?? "",
            dob: detail?["dob"] as? String ?? "",
            work: detail?["work"] as? String ?? "",
            host: detail?["host"] as? String ?? "",
            mood: detail?["mood"] as? String ?? "",
            password: detail?["password"] as? String ?? ""
        )
        
        if let yield = data?["offer"] as? [String: Any] {
            if let sdp = yield["sdp"] as? String {
                // Set calling info in WebRTCClient
                WebRTCClient.instance().callingInfo = CallingInfo(
                    name: data?["name"] as? String ?? "",
                    callType: data?["call_type"] as? String ?? "",
                    isReceivingCall: true,
                    sdp: sdp,
                    data: info
                )
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CallViewController") as! CallViewController
                rootViewController.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    
}

