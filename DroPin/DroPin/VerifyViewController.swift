//
//  VerifyViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class VerifyViewController : UIViewController {
    
    var codeField : UITextField!
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
          
          codeField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
          codeField.placeholder = "code"
          codeField.textColor = .black
          self.view.addSubview(codeField)
    }
}
