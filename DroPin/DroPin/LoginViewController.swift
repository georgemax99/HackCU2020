//
//  LoginViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    var phoneNumberField : UITextField!
    var submitButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }

    func initUI() {
        phoneNumberField = UITextField(frame: CGRect(x: 100, y: 500, width: 200, height: 100))
        phoneNumberField.placeholder = "Phone number"
        phoneNumberField.textColor = .black
        self.view.addSubview(phoneNumberField)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        //submitButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        self.view.backgroundColor = .white
    }
}
