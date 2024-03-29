//
//  Careboard.swift
//  TransliteratingKeyboard
//
//  Created by Andong Zhan on 5/13/16.
//  Copyright (c) 2016 Andong Zhan. All rights reserved.
//

import UIKit

//let kCatTypeEnabled = "kCatTypeEnabled"

class Careboard: KeyboardViewController {
    
    let takeDebugScreenshot: Bool = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        NSUserDefaults.standardUserDefaults().registerDefaults([kCatTypeEnabled: true])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func keyPressed(key: Key) {
        let textDocumentProxy = self.textDocumentProxy
        
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        textDocumentProxy.insertText(keyOutput)
        
//        if !NSUserDefaults.standardUserDefaults().boolForKey(kCatTypeEnabled) {
//            textDocumentProxy.insertText(keyOutput)
//            return
//        }
        
//        if key.type == .Character || key.type == .SpecialCharacter {
//            if let context = textDocumentProxy.documentContextBeforeInput {
//                if context.characters.count < 2 {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//                
//                var index = context.endIndex
//                
//                index = index.predecessor()
//                if context[index] != " " {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//                
//                index = index.predecessor()
//                if context[index] == " " {
//                    textDocumentProxy.insertText(keyOutput)
//                    return
//                }
//
//                textDocumentProxy.insertText("\(randomCat())")
//                textDocumentProxy.insertText(" ")
//                textDocumentProxy.insertText(keyOutput)
//                return
//            }
//            else {
//                textDocumentProxy.insertText(keyOutput)
//                return
//            }
//        }
//        else {
//            textDocumentProxy.insertText(keyOutput)
//            return
//        }
    }
    
    override func setupKeys() {
        super.setupKeys()
        
        if takeDebugScreenshot {
            if self.layout == nil {
                return
            }
            
            for page in keyboard.pages {
                for rowKeys in page.rows {
                    for key in rowKeys {
                        if let keyView = self.layout!.viewForKey(key) {
                            keyView.addTarget(self, action: #selector(Careboard.takeScreenshotDelay), forControlEvents: .TouchDown)
                        }
                    }
                }
            }
        }
    }
    
    override func createBanner() -> ExtraView? {
        return CareboardBanner(globalColors: self.dynamicType.globalColors, darkMode: false, solidColorMode: self.solidColorMode())
    }
    
    func takeScreenshotDelay() {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(Careboard.takeScreenshot), userInfo: nil, repeats: false)
    }
    
    func takeScreenshot() {
        if !CGRectIsEmpty(self.view.bounds) {
            UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
            
            let oldViewColor = self.view.backgroundColor
            self.view.backgroundColor = UIColor(hue: (216/360.0), saturation: 0.05, brightness: 0.86, alpha: 1)
            
            let rect = self.view.bounds
            UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
            // var context = UIGraphicsGetCurrentContext()
            self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            // let name = (self.interfaceOrientation.isPortrait ? "Screenshot-Portrait" : "Screenshot-Landscape")
            let name = (self.interfaceOrientation.isPortrait ? "Screenshot-Portrait" : "Screenshot-Landscape")
            let imagePath = "/Users/archagon/Documents/Programming/OSX/RussianPhoneticKeyboard/External/tasty-imitation-keyboard/\(name).png"
            
            if let pngRep = UIImagePNGRepresentation(capturedImage) {
                pngRep.writeToFile(imagePath, atomically: true)
            }
            
            self.view.backgroundColor = oldViewColor
        }
    }
}

//func randomCat() -> String {
//    let cats = "🐱😺😸😹😽😻😿😾😼🙀"
//    
//    let numCats = cats.characters.count
//    let randomCat = arc4random() % UInt32(numCats)
//    
//    let index = cats.startIndex.advancedBy(Int(randomCat))
//    let character = cats[index]
//    
//    return String(character)
//}
