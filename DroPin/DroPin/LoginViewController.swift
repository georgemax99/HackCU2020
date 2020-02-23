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
    var confirmButton : UIButton!
    var errorLabel : UILabel!
    var backButton : UIButton!


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
        
        errorLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 200, height: 50))
        errorLabel.text = "put error here"
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        self.view.addSubview(errorLabel)
        
        var textfield : UIImageView
        textfield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 100, width: 280, height: 50));
        textfield.image = UIImage(named:"Text box")
        textfield.center.x = self.view.center.x
        self.view.addSubview(textfield)
        
        phoneNumberField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65 - 100, width: 240, height: 50))
        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Enter Phone #", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        phoneNumberField.textColor = .white
        phoneNumberField.center.x = self.view.center.x + 60
        self.view.addSubview(phoneNumberField)
        
        var icon : UIImageView
        icon = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height * 0.65 - 450, width: 200, height: 200));
        icon.image = UIImage(named:"plogo")
        icon.center.x = self.view.center.x
        self.view.addSubview(icon)
        
        var sin : UIImageView
        sin = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height * 0.65 - 270, width: 200, height: 100));
        sin.image = UIImage(named:"Sign in (White)")
        sin.center.x = self.view.center.x
        self.view.addSubview(sin)
        
        confirmButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.65, width: 200, height: 100))
        confirmButton.setTitle("login", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setImage(UIImage(named: "submitbutton"), for: .normal)
        confirmButton.center.x = self.view.center.x
        confirmButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(confirmButton)
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.65 - 560, width: 100, height: 100))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 160
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

