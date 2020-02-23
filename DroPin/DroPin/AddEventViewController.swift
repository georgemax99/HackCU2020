//
//  AddEventViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class AddEventViewController : UIViewController {
    
    var eventNameField : UITextField!
    var numNeededField : UITextField!
    var submitButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI() {
        eventNameField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        eventNameField.placeholder = "code"
        eventNameField.textColor = .black
        self.view.addSubview(eventNameField)
        
        numNeededField = UITextField(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        numNeededField.placeholder = "code"
        numNeededField.textColor = .black
        self.view.addSubview(numNeededField)
        
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
