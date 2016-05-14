//
//  ViewController.swift
//  TransliteratingKeyboard
//
//  Created by Andong Zhan on 6/9/14.
//  Copyright (c) 2016 Andong Zhan. All rights reserved.
//

import UIKit

class HostingAppViewController: UIViewController {
    
    @IBOutlet var stats: UILabel?
    @IBOutlet weak var user: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HostingAppViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HostingAppViewController.keyboardDidHide), name: UIKeyboardDidHideNotification, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HostingAppViewController.keyboardDidChangeFrame(_:)), name: UIKeyboardDidChangeFrameNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss() {
        for view in self.view.subviews {
            if let inputView = view as? UITextField {
                inputView.resignFirstResponder()
            }
        }
    }
    
    var startTime: NSTimeInterval?
    var firstHeightTime: NSTimeInterval?
    var secondHeightTime: NSTimeInterval?
    var referenceHeight: CGFloat = 216
    
    func keyboardWillShow() {
        if startTime == nil {
            startTime = CACurrentMediaTime()
        }
    }
    
    @IBAction func userDidSet(sender: UITextField) {
        if let user = sender.text{
            print(user)
            //let userDefaults = NSUserDefaults(suiteName: "com.zad.careboard")
            //userDefaults!.setObject(user, forKey: "user")
            //NSUserDefaults.standardUserDefaults().setObject(user, forKey: "userKey")
            //print(NSUserDefaults.standardUserDefaults().stringForKey("userKey"))
        }
    }
    
    func keyboardDidHide() {
        startTime = nil
        firstHeightTime = nil
        secondHeightTime = nil
        
        self.stats?.text = "(Waiting for keyboard...)"
    }
    
    func keyboardDidChangeFrame(notification: NSNotification) {
        //let frameBegin: CGRect! = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue
        let frameEnd: CGRect! = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        
        if frameEnd.height == referenceHeight {
            if firstHeightTime == nil {
                firstHeightTime = CACurrentMediaTime()
                
                if let startTime = self.startTime {
                    if let firstHeightTime = self.firstHeightTime {
                        let formatString = NSString(format: "First: %.2f, Total: %.2f", (firstHeightTime - startTime), (firstHeightTime - startTime))
                        self.stats?.text = formatString as String
                    }
                }
            }
        }
        else if frameEnd.height != 0 {
            if secondHeightTime == nil {
                secondHeightTime = CACurrentMediaTime()

                if let startTime = self.startTime {
                    if let firstHeightTime = self.firstHeightTime {
                        if let secondHeightTime = self.secondHeightTime {
                            let formatString = NSString(format: "First: %.2f, Second: %.2f, Total: %.2f", (firstHeightTime - startTime), (secondHeightTime - firstHeightTime), (secondHeightTime - startTime))
                            self.stats?.text = formatString as String
                        }
                    }
                }
            }
        }
    }
}

