//
//  VerifyViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class VerifyViewController : UIViewController {
    
    var codeField : UITextField!
    var errorLabel : UILabel!
    var verifyButton : UIButton!
    var backButton : UIButton!
    
    var authorized = true
    
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
        
        var codefield : UIImageView
        codefield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.5, width: 240, height: 60));
        codefield.image = UIImage(named:"Text box")
        codefield.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.0175
        self.view.addSubview(codefield)
        
        let textField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.5, width: 180, height: 60))
        textField.attributedPlaceholder = NSAttributedString(string: "Confirmation Code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.025
        self.view.addSubview(textField)
        
        var longw : UIImageView
        longw = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.6, width: 240, height: 50));
        longw.image = UIImage(named:"longwords")
        longw.center.x = self.view.center.x
        self.view.addSubview(longw)
        
        var almost : UIImageView
        almost = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.7, width: 200, height: 50));
        almost.image = UIImage(named:"Almost there")
        almost.center.x = self.view.center.x
        self.view.addSubview(almost)
        
        var icon : UIImageView
        icon = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.9, width: 180, height: 190));
        icon.image = UIImage(named:"plogo")
        icon.center.x = self.view.center.x
        self.view.addSubview(icon)
        
        
        verifyButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.35, width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.1))
        verifyButton.setTitle("login", for: .normal)
        verifyButton.setTitleColor(.black, for: .normal)
        verifyButton.setImage(UIImage(named: "Verify"), for: .normal)
        verifyButton.center.x = self.view.center.x
        verifyButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(verifyButton)
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.08, width: 50, height: 50))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 140
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        
        
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
    
    @objc func backAction(){
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
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
                                
                if responseString.contains("name") {
                    DispatchQueue.main.async {
                        self.saveUser(json: responseString)
                        self.checkAuthorizationStatus()
                        
                        if self.authorized {
                            self.segueToMapVC()
                        } else {
                            self.segueToAccessVC()
                        }
                        
                    }
                } else if responseString == "1" {
                    //phone number already in use
                    //code does not match
                }
                
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
    
    func segueToMapVC() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    func segueToAccessVC() {
        let vc = AccessViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    func saveUser(json: String) {
        let jsonData = Data(json.utf8)
        
        UserDefaults.standard.set(jsonData, forKey: "User")
    }
    
    func checkAuthorizationStatus() {
        checkNotificationAuthorizationStatus()
        checkLocationAuthoizationStatus()
    }
    
    func checkNotificationAuthorizationStatus() {
        let userNotification = UNUserNotificationCenter.current()
        userNotification.getNotificationSettings(completionHandler: { (notificationSettings) in
            if notificationSettings.authorizationStatus == .authorized {
                print("Authorized for notifications")
                
            } else {
                print("Not authorized for notifications")
                //Show user how to enable notifications
                self.authorized = false
            }
        })
    }
    
    func checkLocationAuthoizationStatus() {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .authorizedAlways ||  CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                print("Authorized for location services")
            } else {
                //Show user how to enable location services for the application
                print("Not authorized for location services")
                self.authorized = false
            }
        } else {
            //Entire phone is not enabled for location services
            //Show user how to enable location services
            self.authorized = false
        }
    }
}
