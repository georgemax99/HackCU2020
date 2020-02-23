//
//  ViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loginButton : UIButton!
    var signupButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI() {
        loginButton = UIButton(frame: CGRect(x: 100, y: 1700, width: 200, height: 100))
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setImage(UIImage(named: "Sign_inButton"), for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: 100, y: 600, width: 200, height: 100))
        signupButton.setTitle("Register", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.setImage(UIImage(named: "RegisterButton"), for: .normal)
        signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
    }
    
    @objc func loginAction() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
        
    }
    
    @objc func signupAction() {
        let vc = SignupViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}

