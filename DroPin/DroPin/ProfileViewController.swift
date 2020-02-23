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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initUI()
    }
    
    func initUI() {
        
        let decoder = JSONDecoder()
        if let userData = UserDefaults.standard.object(forKey: "User") {
            do {
                let user = try decoder.decode(User.self, from: userData as! Data)
        
                nameLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
                nameLabel.text = user.name
                nameLabel.textColor = .black
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
        
        self.view.backgroundColor = .white
    }
    
    @objc func segueToAddInterestsVC() {
        let vc = AddInterestsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
