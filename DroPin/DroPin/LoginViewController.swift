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
    var backButton : UIButton!


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
        
        backButton = UIButton(frame: CGRect(x: -25, y: 0, width: 200, height: 100))
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        if let phoneNumber = phoneNumberField.text {
                    
                    
            if phoneNumber != "" {
                let parameters : [String : Any] = [
                    "phoneNumber" : phoneNumber
                ]
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                sendLoginPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/login", parameters: parameters)
                
            } else {
                //Phone number is empty
                errorLabel.text = "Phone # Field is Empty"
                errorLabel.isHidden = false
            }
            
            
        }
    }
    
    @objc func backAction(){
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
            
    func sendLoginPost(url : String, parameters : [String : Any]) {
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
                    //no account found for that phone number
                    self.errorLabel.text = "No Account Found for that Phone #"
                    self.errorLabel.isHidden = false
                }
                
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
    
    func segueToVerify() {
        let vc = VerifyViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
}

