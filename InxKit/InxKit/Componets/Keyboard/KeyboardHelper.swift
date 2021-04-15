//
//  KeyboardHelper.swift
//  InxKit
//
//  Created by Patrick W on 2021/4/16.
//

import UIKit

class KeyboardHelper: NSObject {
    
    /// 点击空白部分收起键盘
    var shouldResignOnTouchOutside = false {
        didSet {
            resignFirstResponderGesture.isEnabled = shouldResignOnTouchOutside
        }
    }
    
    static let helper = KeyboardHelper()
    
    private weak var responseView: UIView?
    
    private lazy var resignFirstResponderGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponder(_:)))
        tap.isEnabled = shouldResignOnTouchOutside
        return tap
    }()
    
    override init() {
        super.init()
        addNotifications()
    }
    
    deinit {
        removeNotifications()
    }
    
    private func addNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(didBeginEdit(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(didEndEdit(_:)), name: UITextField.textDidEndEditingNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(didBeginEdit(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(didEndEdit(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    private func removeNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        notificationCenter.removeObserver(self, name: UITextField.textDidEndEditingNotification, object: nil)
        notificationCenter.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        notificationCenter.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    private func resignFirstResponder() {
        guard let current = responseView else {
            return
        }
        if !current.resignFirstResponder() {
            current.becomeFirstResponder()
        }
    }
    
    @objc private func didBeginEdit(_ notification: Notification) {
        guard let current = notification.object as? UIView else {
            return
        }
        responseView = current
        responseView?.window?.addGestureRecognizer(resignFirstResponderGesture)
    }
    
    @objc private func didEndEdit(_ notification: Notification) {
        responseView?.window?.removeGestureRecognizer(resignFirstResponderGesture)
    }
    
    @objc private func resignFirstResponder(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            resignFirstResponder()
        }
    }
}
