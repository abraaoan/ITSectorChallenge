//
//  Utils.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 18/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    public static func stringfy(_ value: Any) -> String {
        if let v = value as? Int {
            return String(v)
        } else if let v = value as? Float {
            return String(v)
        } else if let v = value as? Double {
            return String(v)
        } else if let v = value as? Data {
            return String(data: v, encoding: .utf8) ?? ""
        } else if let v = value as? [String: Any] {
            var result = ""
            
            for (key, value) in v {
                result += "\(key)=\(stringfy(value))"
            }
            
            return result
        } else if let v = value as? String {
            return v
        } else {
            return ""
        }
    }
}
