//
//  Router.swift
//  Convex Vchat
//
//  Created by 1234 on 6/10/20.
//  Copyright © 2020 n0. All rights reserved.
//

import Foundation

// MARK:- Storyboard Id
struct Storyboard {
    
    static let Ids = Storyboard()
    //MARK:- Before Login/Signup
    let LaunchViewController = "LaunchViewController"
    let SignUpUserTableViewController = "SignUpUserTableViewController"

    let VerificationCodeViewController = "VerificationCodeViewController"
    let MobileNoViewController = "MobileNoViewController"
    let DOBViewController = "DOBViewController"
    
    //MARK:- After Login/Signup
    let HomeViewController = "HomeViewController"
    let ContactsViewController = "ContactsViewController"
    let NavigationVC = "NavigationVC"
    
    let CallViewController = "CallViewController"


     

      
}

//MARK:- XIB Cell Names
struct XIB {
    
    static let Names = XIB()
    let WalkThroughView = "WalkThroughView"
    let LocationTableViewCell = "LocationTableViewCell"
    let LocationHeaderTableViewCell = "LocationHeaderTableViewCell"
    let ServiceSelectionCollectionViewCell = "ServiceSelectionCollectionViewCell"
    let LocationSelectionView = "LocationSelectionView"
    let ServiceSelectionView = "ServiceSelectionView"
    let RequestSelectionView = "RequestSelectionView"
    let LoaderView = "LoaderView"
    let RideStatusView = "RideStatusView"
    let InvoiceView = "InvoiceView"
    let RatingView = "RatingView"
    let YourTripCell = "YourTripCell"
    let PassbookTableViewCell = "PassbookTableViewCell"
    let RateView = "RateView"
    let RideNowView = "RideNowView"
    let CancelListTableViewCell = "CancelListTableViewCell"
    let ReasonView = "ReasonView"
    let CouponCollectionViewCell = "CouponCollectionViewCell"
    let CouponView = "CouponView"
    let PassbookWalletTransaction = "PassbookWalletTransaction"
    let disputeCell = "DisputeCell"
    let DisputeLostItemView = "DisputeLostItemView"
    let DisputeSenderCell = "DisputeSenderCell"
    let DisputeReceiverCell = "DisputeReceiverCell"
    let DisputeStatusView = "DisputeStatusView"
    let NotificationTableViewCell = "NotificationTableViewCell"
    let QRCodeView = "QRCodeView"
}

//MARK:- Notification
extension Notification.Name {
    
   public static let providers = Notification.Name("providers")
    public static let index = Notification.Name("index")
}



