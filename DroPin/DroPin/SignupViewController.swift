//
//  SignupViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    var nameField : UITextField!
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
        
        nameField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        nameField.placeholder = "name"
        nameField.textColor = .black
        self.view.addSubview(nameField)
        
        phoneNumberField = UITextField(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        phoneNumberField.placeholder = "Phone number"
        phoneNumberField.textColor = .black
        self.view.addSubview(phoneNumberField)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 100, width: 500, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        if let name = nameField.text, let phoneNumber = phoneNumberField.text {
            
            
            if name != "" && phoneNumber != "" {
                let parameters : [String : Any] = [
                    "phoneNumber" : phoneNumber,
                    "name" : name
                ]
                
                sendSignupPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/signup", parameters: parameters)
                
            } else if name == "" && phoneNumber == "" {
                //name is empty
                //show error
            } else if name == "" {
                
            } else if phoneNumber == "" {
                
            }
            
            
        }
    }
    
    func sendSignupPost(url : String, parameters : [String : Any]) {
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
                        self.segueToVerify()
                    }
                } else if responseString == "1" {
                    //phone number already in use
                }
                
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
    
    func segueToVerify() {
        
    }
    
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
