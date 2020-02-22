//
//  LoginViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    var phoneNumberField : UITextField!
    var submitButton : UIButton!
    var errorLabel : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }

    func initUI() {
        
        errorLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 200, height: 50))
        errorLabel.text = "put error here"
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        self.view.addSubview(errorLabel)
        
        phoneNumberField = UITextField(frame: CGRect(x: 100, y: 500, width: 200, height: 100))
        phoneNumberField.placeholder = "Phone number"
        phoneNumberField.textColor = .black
        self.view.addSubview(phoneNumberField)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        
    }
}
