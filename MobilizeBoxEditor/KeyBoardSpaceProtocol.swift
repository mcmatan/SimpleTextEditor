//
//  KeyBoardSpaceProtocol.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

protocol KeyboardSpaceProtocol {
    func addObservers()
    func removeObservers()
    func keyBoardHeightDidChange(height: CGFloat) 
    func keyboardWillShow(notification:NSNotification) -> CGFloat
    var keyBoardHeight: CGFloat {get set}
}

private var keyBoardKey: UInt8 = 0
extension  UIViewController: KeyboardSpaceProtocol {
    
    var keyBoardHeight: CGFloat {
        get {
            return objc_getAssociatedObject(self, &keyBoardKey) as! CGFloat
        }
        set { objc_setAssociatedObject(self, &keyBoardKey, newValue,  objc_AssociationPolicy(rawValue: 0)!) }
    }
    
    func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification:NSNotification) -> CGFloat {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        
        var selfAsProtocol = self as KeyboardSpaceProtocol
        selfAsProtocol.keyBoardHeight = keyboardRectangle.height
        self.keyBoardHeightDidChange(self.keyBoardHeight)
        
        return keyboardRectangle.height
    }
    
    func keyboardWillHide(notification:NSNotification) {
        
        var selfAsProtocol = self as KeyboardSpaceProtocol
        selfAsProtocol.keyBoardHeight = 0
        self.keyBoardHeightDidChange(self.keyBoardHeight)
    }
    
    func keyBoardHeightDidChange(height: CGFloat) {
        
    }
}