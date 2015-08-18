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
    var currentTextField:UITextField?
    var kbNotification: NSNotification?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.currentTextField = textField;
        
        if ((self.kbNotification) != nil)
        {
            keyboardWillBeHidden(self.kbNotification!)
        }

    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        self.kbNotification = nil
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func keyboardWillBeShown(notification: NSNotification){
        self.kbNotification = notification
        let userInfo = notification.userInfo!
        
        if let kbsize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size
        {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbsize.height, right: 0)
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            let screenHeight = screenSize.height
            let height:CGFloat = screenHeight - (kbsize.height)-(self.currentTextField!.frame.size.width)
            
            if(self.currentTextField!.frame.origin.y >= height )
            {
                var scrollPoint: CGPoint  = CGPointMake(0.0, self.currentTextField!.frame.origin.y - (kbsize.height));
                self.scrollView .setContentOffset(scrollPoint, animated: true)
            }
            
        }
    }

}

