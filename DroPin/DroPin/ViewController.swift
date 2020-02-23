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
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = UserDefaults.standard.object(forKey: "User") {
            print("hello")
            segueToMap()
        }
    }
    
    func initUI() {
        loginButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        signupButton.setTitle("sign up", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        self.view.backgroundColor = .white
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
    
    func segueToMap() {
        print("in map segue")
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}

