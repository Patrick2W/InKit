//
//  KeyboardObserver.swift
//  InxKit
//
//  Created by Patrick W on 2021/4/15.
//

import UIKit

class KeyboardObserver: NSObject {
    
    var keyboardStateDidChanged: ((CGRect, TimeInterval, UIView.AnimationOptions, Bool) -> Void)?
    
    override init() {
        super.init()
        addNotifications()
    }
    
    deinit {
        removeNotifications()
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keybordWillShow(_ notification: Notification) {
        keybordDidChanged(notification, isShow: true)
    }
    
    @objc private func keybordWillHide(_ notification: Notification) {
        keybordDidChanged(notification, isShow: false)
    }
    
    private func keybordDidChanged(_ notification: Notification, isShow: Bool) {
        let userInfo = notification.userInfo!
        let targetFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        let options = UIView.AnimationOptions(rawValue: UInt(curve!) << 16 | UIView.AnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        
        keyboardStateDidChanged?(targetFrame!, duration!, options, isShow)
    }
}
