//
//  ProfileViewController.swift
//  DroPin
//
//  Created by Max on 2/23/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    var addInterestsButton : UIButton!
    var nameLabel : UILabel!
    var addLocationButton : UIButton!
    var ProfButton : UIButton!
    var PindButton : UIButton!
    var HomeButton : UIButton!
    
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
        
        let decoder = JSONDecoder()
        if let userData = UserDefaults.standard.object(forKey: "User") {
            do {
                let user = try decoder.decode(User.self, from: userData as! Data)
        
                nameLabel = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.7, width: 200, height: 100))
                nameLabel.text = "Jack Lambert"
                nameLabel.textColor = .white
                nameLabel.center.x = self.view.center.x + UIScreen.main.bounds.height * 0.05
                self.view.addSubview(nameLabel)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        addInterestsButton = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        addInterestsButton.setTitle("Add Interests", for: .normal)
        addInterestsButton.setTitleColor(.black, for: .normal)
        addInterestsButton.addTarget(self, action: #selector(segueToAddInterestsVC), for: .touchUpInside)
        self.view.addSubview(addInterestsButton)
        
        
        
        
        var navb : UIImageView
            navb = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.185, width: UIScreen.main.bounds.height * 0.13, height: UIScreen.main.bounds.height * 0.13));
            navb.image = UIImage(named:"Bar logo base")
            navb.center.x = self.view.center.x
            self.view.addSubview(navb)
            
            var navbtop : UIImageView
            navbtop = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.125, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.125));
            navbtop.image = UIImage(named:"Bar Base")
            navbtop.center.x = self.view.center.x
            self.view.addSubview(navbtop)
                   
            
            var smlogo : UIImageView
            smlogo = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.185, width: UIScreen.main.bounds.height * 0.1, height: UIScreen.main.bounds.height * 0.12));
            smlogo.image = UIImage(named:"Bar Logo")
            smlogo.center.x = self.view.center.x
            self.view.addSubview(smlogo)
            
            addLocationButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.09, width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05))
            addLocationButton.setTitle("add location", for: .normal)
            addLocationButton.setTitleColor(.black, for: .normal)
            addLocationButton.setImage(UIImage(named: "Add_Pins"), for: .normal)
            addLocationButton.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.19
            addLocationButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
            self.view.addSubview(addLocationButton)
            
            ProfButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.09, width: UIScreen.main.bounds.height * 0.035, height: UIScreen.main.bounds.height * 0.05))
            ProfButton.setTitle("Profile", for: .normal)
            ProfButton.setTitleColor(.black, for: .normal)
            ProfButton.setImage(UIImage(named: "Me"), for: .normal)
            ProfButton.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.38
            ProfButton.addTarget(self, action: #selector(segueToProfileVC), for: .touchUpInside)
            self.view.addSubview(ProfButton)
            
            PindButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.09, width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05))
            PindButton.setTitle("MyPind", for: .normal)
            PindButton.setTitleColor(.black, for: .normal)
            PindButton.setImage(UIImage(named: "My Pin'd"), for: .normal)
            PindButton.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.19
            PindButton.addTarget(self, action: #selector(HomeAction), for: .touchUpInside)
            self.view.addSubview(PindButton)
            
            HomeButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.1, width: UIScreen.main.bounds.height * 0.1, height: UIScreen.main.bounds.height * 0.06))
            HomeButton.setTitle("Home", for: .normal)
            HomeButton.setTitleColor(.black, for: .normal)
            HomeButton.setImage(UIImage(named: "Home"), for: .normal)
            HomeButton.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.38
            HomeButton.addTarget(self, action: #selector(HomeAction), for: .touchUpInside)
            self.view.addSubview(HomeButton)
            
            self.view.backgroundColor = .white
    }
        
        @objc func addLocationAction() {
               let vc = AddEventViewController()
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: false, completion: nil)
        }
        
        @objc func HomeAction() {
            let vc = MapViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
        
        @objc func segueToProfileVC() {
            let vc = ProfileViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    
    @objc func segueToAddInterestsVC() {
        let vc = AddInterestsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
