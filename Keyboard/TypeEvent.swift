//
//  TypeEvent.swift
//  CareKeyboard
//
//  Created by Andong Zhan on 5/12/16.
//  Copyright © 2016 Andong Zhan. All rights reserved.
//

import UIKit

class TypeEvent: NSObject, NSCoding{
    var tsp: NSDate
    var keyType: String
    
    // MARK: Types
    struct PropertyKey {
        static let tspKey = "tsp"
        static let keyTypeKey = "keyType"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("typeEventList")
    
    
    init(tsp: NSDate, keyType: String) {
        self.tsp = tsp
        self.keyType = keyType
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(tsp, forKey: PropertyKey.tspKey)
        aCoder.encodeObject(keyType, forKey: PropertyKey.keyTypeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let tsp = aDecoder.decodeObjectForKey(PropertyKey.tspKey) as! NSDate
        
        // Because photo is an optional property of Meal, use conditional cast.
        let keyType = aDecoder.decodeObjectForKey(PropertyKey.keyTypeKey) as! String
        
        
        
        // Must call designated initializer.
        self.init(tsp:tsp,keyType: keyType)
    }
    
}
