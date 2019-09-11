//
//  PasswordStrengthType.swift
//  Password Strength
//
//  Created by MacBook Pro on 11/9/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation


enum StrengthType {
    case weak
    case medium
    case strong
    case veryStrong
}

public enum ValidationRequiredRule {
    case lowerCase
    case uppercase
    case digit
    case specialCharacter
    case oneUniqueCharacter
    case minmumLength
}
