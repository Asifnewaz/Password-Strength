//
//  ViewController.swift
//  Password Strength
//
//  Created by Asif Newaz on 11/9/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Mark: Hooking up with storyboard
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var strengthView : UIView!
    @IBOutlet weak var strengthProgressView : UIProgressView!
    @IBOutlet weak var instructionLabel : UILabel!
    @IBOutlet weak var instructionHeightConstrain: NSLayoutConstraint!
    
    //Mark: inserted paswword is valid or not as per rules
    var isPasswordValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settting Initial values for UIProgressView
        self.strengthProgressView.setProgress(0, animated: true)
        self.instructionLabel.textColor = UIColor.red
        self.instructionLabel.text = ""
        self.instructionLabel.isHidden = true
    }

    
    // Mark: Password Textfield editing Changed
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        
        if let password = passwordTextField.text, password.isNotEmpty {
            self.instructionLabel.isHidden = false
            self.instructionLabel.alpha = 0
            let validationId = PasswordStrengthManager.checkValidationWithUniqueCharacter(pass: password, rules: PasswordRules.passwordRule, minLength: PasswordRules.minPasswordLength, maxLength: PasswordRules.maxPasswordLength)
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: { [weak self] in
                self?.instructionLabel.alpha = CGFloat(validationId.alpha)
                self?.instructionHeightConstrain.constant = CGFloat(validationId.constant)
                self?.instructionLabel.text  = validationId.text
            })
            
            let progressInfo = PasswordStrengthManager.setProgressView(strength: validationId.strength)
            self.isPasswordValid = progressInfo.shouldValid
            self.strengthProgressView.setProgress(progressInfo.percentage, animated: true)
            self.strengthProgressView.progressTintColor = UIColor.colorFrom(hexString: progressInfo.color)
            
        } else {
            self.instructionLabel.isHidden = false
            self.instructionLabel.alpha = 0
            self.strengthProgressView.setProgress(0, animated: true)
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: { [weak self] in
                self?.instructionLabel.alpha = 1
                self?.instructionHeightConstrain.constant = 25
                self?.instructionLabel.text = "Password cannot be empty."
            }) { (_) in
                UIView.animate(withDuration: 0.8, delay: 0, options: [], animations: { [weak self] in
                    self?.instructionLabel.alpha = 1
                    self?.instructionHeightConstrain.constant = 25
                    self?.instructionLabel.isHidden = true
                })
            }
        }
        
    }

}

