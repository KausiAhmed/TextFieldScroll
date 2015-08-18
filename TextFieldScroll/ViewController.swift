//
//  ViewController.swift
//  TextFieldScroll
//
//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonToBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func keyboardWillBeShown(notification: NSNotification){
        
        let userInfo = notification.userInfo!
    
        if let kbsize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size{
            
             self.scrollView .setContentOffset(CGPointMake(0, kbsize.height), animated: true)
        }
    }

}

