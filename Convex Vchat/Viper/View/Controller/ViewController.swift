
import UIKit
import Foundation
import CoreData

private var bottomConstraint : NSLayoutConstraint?
private var imageCompletion : ((UIImage?)->())?
private var constraintValue : CGFloat = 0

extension UIViewController {
    
    func setPresenter(){
        
        if let view = self as? PostViewProtocol {
            
            view.presenter = presenterObject
            view.presenter?.controller = view
            presenterObject = view.presenter
        }
    }
    
    //MARK:- Pop or dismiss View Controller
    
    func popOrDismiss(animation : Bool){
        
        DispatchQueue.main.async {
            
            if self.navigationController != nil {
                
                self.navigationController?.popViewController(animated: animation)
            } else {
                
                self.dismiss(animated: animation, completion: nil)
            }
            
        }
        
    }
    
    
    
    //MARK:- Present
    
    func present(id : String, animation : Bool, fromSB storyBoard: UIStoryboard = Router.main){
        
           let vc = storyBoard.instantiateViewController(withIdentifier: id)
           vc.modalPresentationStyle = .fullScreen 
           self.present(vc, animated: animation, completion: nil)
        
        
    }
     
    
    
    
  @objc  func showToast(string:String) {
           self.view.makeToast(string, duration: 1.0, position: .center)
        
        
        
    }
       
    //MARK:- Push
    
    func push(id : String, animation : Bool){
        
      
        
         print("Identifier", id)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: id){
            self.navigationController?.pushViewController(vc, animated: animation)

        }
    }
    
    //MARK:- Push To Right
    
    func pushRight(toViewController viewController : UIViewController){
        
        self.makePush(transition: convertFromCATransitionSubtype(CATransitionSubtype.fromLeft))
        navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    private func makePush(transition type : String){
        
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push
        transition.subtype = convertToOptionalCATransitionSubtype(type)
        //transition.delegate = self
        navigationController?.view.layer.add(transition, forKey: nil)
        //navigationController?.isNavigationBarHidden = false
        
    }
    
    func popLeft() {
        
        self.makePush(transition: convertFromCATransitionSubtype(CATransitionSubtype.fromRight))
        navigationController?.popViewController(animated: true)
        
    }
    func save( name: String, number: String, exist: Int) {
          
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          // 2
            
            
          let entity =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedContext)!
          
          let person = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          // 3
        person.setValue(name, forKeyPath: "name")

           person.setValue(number, forKeyPath: "mobile")
        person.setValue(exist, forKey: "exist")

  

          do {
            try managedContext.save()
            print("saved number \(person)")

           } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
          }
        
        }
    
       
    
   
    //MARK:- Add observers
    
    func addKeyBoardObserver(with constraint : NSLayoutConstraint){
        
        bottomConstraint = constraint
        
        constraintValue = constraint.constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(info:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
      
    }
    //MARK:- Keyboard will show
    
    @IBAction private func keyboardWillShow(info : NSNotification){
        
        guard let keyboard = (info.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        bottomConstraint?.constant = -(keyboard.height)
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- Keyboard will hide
    
    @IBAction private func keyboardWillHide(info : NSNotification){
        
        bottomConstraint?.constant = constraintValue
        self.view.layoutIfNeeded()
        
    }
    
    
    //MARK:- Back Button Action
    
    @IBAction func backButtonClick() {
        
        self.popOrDismiss(animation: true)
        
    }
    
    //MARK:- Show Image Selection Action Sheet
    
    func showImage(with completion : @escaping ((UIImage?)->())){
        
        let alert = UIAlertController(title: Constants.string.selectSource.localize(), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.string.camera.localize(), style: .default, handler: { (_) in
            self.chooseImage(with: .camera)
        }))
        alert.addAction(UIAlertAction(title: Constants.string.photoLibrary.localize(), style: .default, handler: { (_) in
            self.chooseImage(with: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: Constants.string.Cancel.localize(), style: .cancel, handler:nil))
        alert.view.tintColor = .primary
        imageCompletion = completion
        
        
        alert.popoverPresentationController?.sourceView = alert.view // works for both iPhone & iPad
        
        present(alert, animated: true) {
            print("option menu presented")
        }

//        if let popoverPresentationController = alert.popoverPresentationController {
//
//
//        }
        
//        self.present(alert, animated: true, completion: nil)
        
    }

    // MARK:- Show Image Picker
    
    private func chooseImage(with source : UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
  
   
    
    //MARK:- Show Search Bar with self delegation
    
    @IBAction private func showSearchBar(){
        
       let searchBar = UISearchController(searchResultsController: nil)
       searchBar.searchBar.delegate = self as? UISearchBarDelegate
       searchBar.hidesNavigationBarDuringPresentation = false
       searchBar.dimsBackgroundDuringPresentation = false
       searchBar.searchBar.tintColor = .primary
       self.present(searchBar, animated: true, completion: nil)
        
    }
   
    
}

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        picker.dismiss(animated: true) {
            if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
