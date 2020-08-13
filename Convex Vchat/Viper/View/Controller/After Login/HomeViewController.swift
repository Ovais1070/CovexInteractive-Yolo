//
//  HomeViewController.swift
//  ConvexVchat
//
//  Created by 1234 on 6/22/20.
//  Copyright © 2020 n0. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    var parent2VC: ContactsViewController? = nil
    
    var searchBar = UISearchBar()
    var searchBarButtonItem: UIBarButtonItem?
    var logoImageView   : UIImageView!
    
    
    var menuImg   : UIImage = UIImage(named: "menu")!
    var refreshImg : UIImage = UIImage(named: "refreshBtn")!
    var searchImg : UIImage = UIImage(named: "search2")!
    
    //TopTabBar
    var tabs = [ ViewPagerTab(title: "CALLS", image: UIImage(named: "")) ]
    

    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialVIew()
        BarbuttonInitializer()
        navigationController?.navigationBar.tintColor = .white
    }
    

    func BarbuttonInitializer(){
        self.navigationController?.navigationBar.barStyle = .black
          // Do any additional setup after loading the view.
          let manuBtn : UIBarButtonItem = UIBarButtonItem(image: menuImg,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuBtnPressed(sender:)))
        
          let refreshBtn : UIBarButtonItem = UIBarButtonItem(image: refreshImg,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshBtnPressed(sender:)))
          
          let searchBtn : UIBarButtonItem = UIBarButtonItem(image: searchImg,  style: UIBarButtonItem.Style.plain, target: self, action: #selector(searchPressed(sender:)))
          
          
          let buttons : NSArray = [manuBtn, refreshBtn, searchBtn]
          
          self.navigationItem.rightBarButtonItems = (buttons as! [UIBarButtonItem])
          self.navigationItem.rightBarButtonItem?.tintColor = .white

          searchBtn.tintColor = .white
          refreshBtn.tintColor = .white
          
          searchBar.delegate = self
          searchBar.searchBarStyle = UISearchBar.Style.minimal
    }
    
    

    @IBAction func searchButtonPressed(sender: AnyObject) {
      
    }

    
    func showSearchBar() {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        let button : UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPressed(sender:)))
         self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = button
        
//        navigationItem.setRightBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
          self.searchBar.alpha = 1
          }, completion: { finished in
            self.searchBar.becomeFirstResponder()
            
        })
      }

      func hideSearchBar() {
            BarbuttonInitializer()
            navigationItem.titleView = nil
      }


      //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
      }
    
    
        @objc func cancelPressed(sender: AnyObject){
        
            print("Cancel Btn")
            hideSearchBar()
        }
    
       @objc func menuBtnPressed(sender: AnyObject){
        
            print("Pressed Menu Btn")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        navigationController?.pushViewController(vc, animated: true)
        
        
        }
    
       @objc func refreshBtnPressed(sender: AnyObject){
        
         print("Pressed Refresh Btn")
//        parentVC?.RefreshContacts()
        }
    
    @objc func searchPressed(sender: AnyObject){
    
        showSearchBar()
    }



    func initialVIew()
        {
            
     tabs += [ ViewPagerTab(title: "CONTACTS", image: UIImage(named: "")) ]

           
            self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

            self.title = ""
            
             options = ViewPagerOptions(viewPagerWithFrame:self.view.bounds)

            options.tabType = ViewPagerTabType.basic
            options.tabViewImageSize = CGSize(width: 20, height: 20)
          //options.tabViewTextFont = UIFont(name: "Lato-Bold", size: 14)!
            options.tabViewPaddingLeft = 10
            options.tabViewPaddingRight = 10
          //  options.tabViewTextDefaultColor =  UIColor.init(named: "#868181")!
            options.tabViewBackgroundHighlightColor = .clear
            options.isTabHighlightAvailable = true

            options.fitAllTabsInView = true
            viewPager = ViewPagerController()
            viewPager.options = options
            viewPager.dataSource = self
            viewPager.delegate = self
           options.viewPagerFrame = self.view.bounds
            options.viewPagerFrame = CGRect(x:0, y: 0, width:self.view.frame.width, height:self.view.frame.height )

            self.addChild(viewPager)
            self.view.addSubview(viewPager.view)
            viewPager.didMove(toParent: self)
           // let filterStr = String(gName.filter { !"\r\n".contains($0) })
            self.tabs +=   [ViewPagerTab(title: "filterStr", image: UIImage(named: ""))]
            
           // setfooterBar()
          setNavigationcontroller()

        }
    
    
    
       func setNavigationcontroller(){
            
            if #available(iOS 11.0, *) {
               // self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationController?.navigationBar.barTintColor = GlobaColor.shared.color
                self.navigationController?.isNavigationBarHidden = false
            }
           // title = Constants.string.registerDetails.localize()
            // self.navigationController?.navigationBar.tintColor = UIColor.white
          //   self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(self.backButtonClick))
    //        addGustureforNextBtn()
           // self.view.dismissKeyBoardonTap()
            
     
           
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
extension HomeViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ContactsViewController)  as? ContactsViewController
    
        return vc!
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension HomeViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index - 1)")
        
     

//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
//
//         vc.itemNo = index
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
//            let tabs = all_categories[index]
//           self.addGoogleTracker(ScreenName:"Home " + tabs)
//
//        vc.itemNo = index
    }
    
    
    
}


