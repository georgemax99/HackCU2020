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
        var bgColor : UIImageView
        bgColor = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        bgColor.image = UIImage(named:"bgcolor")
        bgColor.center.x = self.view.center.x
        self.view.addSubview(bgColor)
        

        
        loginButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.35, width: 200, height: 100))
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.center.x = self.view.center.x
        loginButton.setImage(UIImage(named: "Signin"), for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height * 0.35 + 150, width: 200, height: 100))
        signupButton.setTitle("Register", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.center.x = self.view.center.x
        signupButton.setImage(UIImage(named: "RegisterButton"), for: .normal)
        signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        var imageView : UIImageView
        imageView = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.85, width: 300, height: 150));
        imageView.image = UIImage(named:"Logo")
        imageView.center.x = self.view.center.x * 1.15
        self.view.addSubview(imageView)
        var orView : UIImageView
        orView = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.35 + 110, width: 25, height: 25));
        orView.image = UIImage(named:"or")
        orView.center.x = self.view.center.x - 5
        self.view.addSubview(orView)
        
        var slogan : UIImageView
        slogan = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.72, width: 125, height: 40));
        slogan.image = UIImage(named:"Drop_By_")
        slogan.center.x = self.view.center.x - 5
        self.view.addSubview(slogan)
        
        var mapimg : UIImageView
        mapimg  = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height * 0.35 + 180, width: 600, height: 400));
        mapimg.image = UIImage(named:"mapimg")
        mapimg.center.x = self.view.center.x * 1.15
        self.view.addSubview(mapimg)
        
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

