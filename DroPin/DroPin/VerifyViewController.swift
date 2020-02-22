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
    var submitButton : UIButton!
    
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
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        self.view.backgroundColor = .white
        
    }
    
    @objc func submitAction() {
        if let code = codeField.text, let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") {
            if code != "" {
                let parameters : [String : Any] = [
                                   "phoneNumber" : phoneNumber,
                                   "code" : code
                               ]
                               
                               sendCodePost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/verification", parameters: parameters)
            } else {
                //code is empty
            }
        }
    }
    
    func sendCodePost(url : String, parameters : [String : Any]) {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                                
                if responseString == "0" {
                    DispatchQueue.main.async {
                        
                    }
                } else if responseString == "1" {
                    //phone number already in use
                }
                
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
}
