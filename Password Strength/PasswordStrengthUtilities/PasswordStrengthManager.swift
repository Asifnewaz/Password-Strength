//
//  PasswordStrengthManager.swift
//  Password Strength
//
//  Created by MacBook Pro on 11/9/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

struct PasswordStateInfo{
    var text: String = ""
    var identifier: Int = 0
    var constant: Float = 25.0
    var alpha: Float = 1.0
    var allRequirementDone: Bool = false
    var strength: StrengthType = .weak
}

struct ProgressViewInformation{
    var color: String = "000000"
    var percentage: Float = 0.0
    var shouldValid: Bool = false
}


public class PasswordStrengthManager {
    
    // Weak: F44336
    // medium: FFC108
    // good: 04A9F3
    // strog: 8BC34A
    class func setProgressView(strength: StrengthType) -> ProgressViewInformation {
        
        var progressStruct = ProgressViewInformation()
        
        switch strength {
        case .veryStrong:
            progressStruct.shouldValid = true
            progressStruct.percentage = 1.0
            progressStruct.color = PasswordRules.veryStrongStrengthColor
        case .strong:
            progressStruct.shouldValid = true
            progressStruct.percentage = 3/4
            progressStruct.color = PasswordRules.strongStrengthColor
        case .medium:
            progressStruct.shouldValid = false
            progressStruct.percentage = 2/4
            progressStruct.color = PasswordRules.mediumStrengthColor
        case .weak:
            progressStruct.shouldValid = false
            progressStruct.percentage = 1/4
            progressStruct.color = PasswordRules.weakStrengthColor
        default:
            break
        }
        
        return progressStruct
    }
    
    
    class func checkValidationWithUniqueCharacter(pass: String, rules: [ValidationRequiredRule], minLength: Int, maxLength: Int, isUniqueCharRequired: Bool = PasswordRules.isUniqueCharRequired) -> PasswordStateInfo {
        
        var returnModel = PasswordStateInfo()
        let rule: [ValidationRequiredRule] = rules
        let minLength = minLength
        let maxLength = maxLength
        
        var validationCompletion: [ValidationRequiredRule] = []
        
        if pass.satisfiesRegexp("[a-z]") == true {
            validationCompletion.append(.lowerCase)
        }
        
        if pass.satisfiesRegexp("[A-Z]") == true {
            validationCompletion.append(.uppercase)
        }
        if pass.satisfiesRegexp("[0-9]") == true {
            validationCompletion.append(.digit)
        }
        
        if isUniqueCharRequired {
            if uniquecharacter(input: pass) == true {
                validationCompletion.append(.oneUniqueCharacter)
            }
        }
        
        
        if pass.count >= minLength {
            validationCompletion.append(.minmumLength)
        }
        
        if rule.count == validationCompletion.count {
            returnModel.allRequirementDone = true
        }
        
        
        returnModel.strength = strengthChecker(requiredRule: rule, containingRule: validationCompletion, minLength: minLength, maxLength: maxLength, currentLength: pass.count)
        returnModel.allRequirementDone = isRequiredRuleInputed(requiredRule: rule, containingRule: validationCompletion)
        returnModel.text = allRequirementCheck(requiredRule: rule, containingRule: validationCompletion,minimum: minLength)
        
        return returnModel
    }
    
    
    class func strengthChecker(requiredRule: [ValidationRequiredRule], containingRule: [ValidationRequiredRule], minLength: Int, maxLength: Int, currentLength: Int) -> StrengthType {
        
        if containingRule.count > requiredRule.count {
            return .veryStrong
        } else if containingRule.count == requiredRule.count {
            if containingRule == requiredRule {
                return .strong
            } else {
                return .medium
            }
        } else if (containingRule.count > 1) && ( containingRule.count < requiredRule.count) {
            return .medium
        } else {
            return .weak
        }
    }
    
    
    class func isRequiredRuleInputed(requiredRule: [ValidationRequiredRule], containingRule: [ValidationRequiredRule]) -> Bool {
        
        var requirementFullFill: Bool = false
        if requiredRule.count == containingRule.count {
            requirementFullFill = true
        }
        
        return requirementFullFill
    }
    
    
    class func allRequirementCheck(requiredRule: [ValidationRequiredRule], containingRule: [ValidationRequiredRule], minimum: Int) -> String {
        
        var requiredString: String = ""
        
        for eachRule in requiredRule {
            switch eachRule {
            case .lowerCase:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Need a lowercase"
                    return requiredString
                }
                
            case .uppercase:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Need a uppercase"
                    return requiredString
                }
                
            case .digit:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Need a digit"
                    return requiredString
                }
                
            case .oneUniqueCharacter:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Need a unique character"
                    return requiredString
                }
                
            case .specialCharacter:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Need a special character"
                    return requiredString
                }
            case .minmumLength:
                if containingRule.contains(eachRule) {
                    requiredString = ""
                } else {
                    requiredString = "Minimum \(minimum) character required"
                    return requiredString
                }
            }
        }
        
        return requiredString
    }
    
    class func uniquecharacter(input: String) -> Bool {
        
        var isUnique: Bool = false
        var charac: [String] = []
        
        for item in input {
            charac.append("\(item)")
        }
        
        var counts: [String: Int] = [:]
        for character in charac {
            counts[character] = (counts[character] ?? 0) + 1
        }
        let nonRepeatingCharacters = charac.filter({counts[$0] == 1})
        
        if nonRepeatingCharacters.count > 0 {
            isUnique = true
        } else {
            isUnique = false
        }
        
        return isUnique
    }
    
}



