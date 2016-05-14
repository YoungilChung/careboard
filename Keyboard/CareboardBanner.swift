//
//  CareboardBanner.swift
//  TastyImitationKeyboard
//
//  Created by Andong Zhan on 5/13/16.
//  Copyright (c) 2014 Andong Zhan. All rights reserved.
//

import UIKit

/*
This is the demo banner. The banner is needed so that the top row popups have somewhere to go. Might as well fill it
with something (or leave it blank if you like.)
*/

class CareboardBanner: ExtraView {
    
    //var catSwitch: UISwitch = UISwitch()
    var careLabel: UILabel = UILabel()
    let dateFormatter = NSDateFormatter()
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
        
//        self.addSubview(self.catSwitch)
        self.addSubview(self.careLabel)
        dateFormatter.dateFormat = "HH:mm:ss"
//        self.catSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(kCatTypeEnabled)
//        self.catSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
//        self.catSwitch.addTarget(self, action: #selector(CareboardBanner.respondToSwitch), forControlEvents: UIControlEvents.ValueChanged)
        
//        self.updateAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        self.catSwitch.center = self.center
        self.careLabel.center = self.center
        self.careLabel.frame.origin = CGPointMake(0, self.careLabel.frame.origin.y)
    }
    
//    func respondToSwitch() {
//        NSUserDefaults.standardUserDefaults().setBool(self.catSwitch.on, forKey: kCatTypeEnabled)
//        self.updateAppearance()
//    }
    
    func updateAppearance( e:TypeEvent) {
//        if self.catSwitch.on {
//            self.catLabel.text = "😺"
//            self.catLabel.alpha = 1
//        }
//        else {
//            self.catLabel.text = "🐱"
//            self.catLabel.alpha = 0.5
//        }
//        if user.characters.count != 0{
//            self.careLabel.text = "user: \(user)    \(dateFormatter.stringFromDate(e.tsp)) \(e.keyType)"
//        }else{
//            self.careLabel.text = "\(dateFormatter.stringFromDate(e.tsp)) \(e.keyType)"
//        }
//        print(user)
        self.careLabel.text = "\(dateFormatter.stringFromDate(e.tsp)) \(e.keyType)"
        self.careLabel.sizeToFit()
    }
}
