//
//  ViewController.swift
//  InxKit
//
//  Created by Patrick W on 2021/4/15.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var keyboardObser = KeyboardObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardObser.keyboardStateDidChanged = { rect, duration, options, isShow in
            
            print("rect: \(rect)")
        }
    }
    
}

