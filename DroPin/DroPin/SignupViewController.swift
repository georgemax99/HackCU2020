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
    var backButton : UIButton!
    var loginbut : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }

    func initUI() {
        
        var bgColor : UIImageView
        bgColor = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        bgColor.image = UIImage(named:"bgcolor")
        bgColor.center.x = self.view.center.x
        self.view.addSubview(bgColor)
        
        errorLabel = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.8, width: 200, height: 50))
        errorLabel.text = "put error here"
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        self.view.addSubview(errorLabel)
        
        var textfield : UIImageView
        textfield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 95, width: 240, height: 60));
        textfield.image = UIImage(named:"Text box")
        textfield.center.x = self.view.center.x
        self.view.addSubview(textfield)
        
        var txtfield : UIImageView
        txtfield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 180, width: 240, height: 60));
        txtfield.image = UIImage(named:"Text box")
        txtfield.center.x = self.view.center.x
        self.view.addSubview(txtfield)
        
        nameField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 180, width: 200, height: 60))
        nameField.attributedPlaceholder = NSAttributedString(string: "Enter Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameField.textColor = .white
        nameField.center.x = self.view.center.x + 45
        self.view.addSubview(nameField)
        
        phoneNumberField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 95, width: 200, height: 60))
        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Enter Phone #", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        phoneNumberField.textColor = .white
        phoneNumberField.center.x = self.view.center.x + 40
        self.view.addSubview(phoneNumberField)
        
        var icon : UIImageView
        icon = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height * 0.65 - 435, width: 175, height: 180));
        icon.image = UIImage(named:"plogo")
        icon.center.x = self.view.center.x
        self.view.addSubview(icon)
        
        var sup: UIImageView
        sup = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height * 0.65 - 250, width: 150, height: 45));
        sup.image = UIImage(named:"Register")
        sup.center.x = self.view.center.x
        self.view.addSubview(sup)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 20, width: 200, height: 90))
        submitButton.setTitle("submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.setImage(UIImage(named: "submitbutton"), for: .normal)
        submitButton.center.x = self.view.center.x
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.08, width: 50, height: 50))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 140
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        var already : UIImageView
        already = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height * 0.65 + 140, width: 160, height: 25));
        already.image = UIImage(named:"Already registered")
        already.center.x = self.view.center.x
        self.view.addSubview(already)
        
        loginbut = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.65 + 170, width: 50, height: 20))
        loginbut.setTitle("regButton", for: .normal)
        loginbut.setImage(UIImage(named: "Small sign in"), for: .normal)
        loginbut.center.x = self.view.center.x
        loginbut.addTarget(self, action: #selector(logAction), for: .touchUpInside)
        self.view.addSubview(loginbut)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        if let name = nameField.text, let phoneNumber = phoneNumberField.text {
            
            
            if name != "" && phoneNumber != "" {
                let parameters : [String : Any] = [
                    "phoneNumber" : phoneNumber,
                    "name" : name
                ]
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                sendSignupPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/signup", parameters: parameters)
                
            } else if name == "" && phoneNumber == "" {
                //name is empty
                //show error
                errorLabel.text = "Name and Phone # Fields are Empty"
                errorLabel.isHidden = false
            } else if name == "" {
                errorLabel.text = "Name Field is Empty"
                errorLabel.isHidden = false
            } else if phoneNumber == "" {
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
    
    @objc func logAction(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
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
                    self.errorLabel.text = "Phone # already in use"
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
