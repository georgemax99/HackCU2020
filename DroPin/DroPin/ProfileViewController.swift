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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initUI()
    }
    
    func initUI() {
        
        addInterestsButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
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
