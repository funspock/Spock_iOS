//
//  KeyManager.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/04.
//  Copyright © 2019 相川健太. All rights reserved.
//

import Foundation

struct KeyManager {
    
    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")
    
    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }
    
    func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key]! as AnyObject
    }
}
