//
//  MapViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class MapViewController : UIViewController {
    
    var addLocationButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI() {
        addLocationButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        addLocationButton.setTitle("add location", for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        self.view.addSubview(addLocationButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func addLocationAction() {
        let vc = AddEventViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
}
