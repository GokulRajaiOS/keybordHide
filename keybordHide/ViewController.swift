//
//  ViewController.swift
//  keybordHide
//
//  Created by Gokulraja on 28/02/22.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    var activeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        userNameTextField.delegate = self
        passwordTextField.delegate = self
        let center: NotificationCenter = NotificationCenter.default;center.addObserver(self, selector: #selector(keyborddidshow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keybordWilHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func keybordWilHide(notification:Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height:self.view.bounds.height )
        } , completion: nil)
    }
    @objc func keyborddidshow(notification: Notification){
        let info: NSDictionary =  notification.userInfo! as NSDictionary
        let keybordsize = (info[ViewController.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keybordy = self.view.frame.height - keybordsize.height
         
        let editingTextFieldy : CGFloat! = self.activeTextField?.frame.origin.y
        if self.view.frame.origin.y >= 0 {
        if editingTextFieldy > keybordy - 130{
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations:{ self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldy! - (keybordy - 130)), width: self.view.bounds.width, height: self.view.bounds.height)
                
            }
        , completion: nil)
        }
        }
    }

}

