//
//  StringExtension.swift
//  Password Strength
//
//  Created by Asif Newaz  on 11/9/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

extension String {
    /**
     true if self contains characters.
     */
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    
    func satisfiesRegexp(_ regexp: String) -> Bool {
        return range(of: regexp, options: .regularExpression) != nil
    }
}

