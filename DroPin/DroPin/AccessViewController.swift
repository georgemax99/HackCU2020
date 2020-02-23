//
//  AccessViewController.swift
//  PartyFavor
//
//  Created by Max on 2/11/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Speech
import CoreLocation
import Contacts

class AccessViewController: UIViewController {

    var accessLabel : UILabel!
    var submitButton : UIButton!
    var count = 1
    var locationInit = false
    var backButton : UIButton!
    
    let locationManager = CLLocationManager()
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.

        initUI()
    }

    func initUI() {
        
        var bgColor : UIImageView
        bgColor = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        bgColor.image = UIImage(named:"bgcolor")
        bgColor.center.x = self.view.center.x
        self.view.addSubview(bgColor)
        
        accessLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 200, height: 200))
        accessLabel.text = "Notifications"
        accessLabel.textColor = .black
        self.view.addSubview(accessLabel)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.35, width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.1))
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.setImage(UIImage(named: "submitButton"), for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.08, width: 50, height: 50))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 140
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        showAccess()
        count += 1
        
    }
    
    @objc func backAction(){
           let vc = LoginViewController()
           vc.modalPresentationStyle = .fullScreen
           present(vc, animated: false, completion: nil)
    }
    
    func segueToMapVC() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    func showAccess() {
        if count == 1 {
            registerForPushNotifications()
            accessLabel.text = "Locations"
        } else if count == 2 {
            requestLocationServices()
        }
    }
    
    
    func registerForPushNotifications() {
        if #available(iOS 12.0, *) {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge, .criticalAlert]) {
                    [weak self] granted, error in
                    
                    print("Permission granted: \(granted)")
                    if granted {
                        //User authorized notifications
                        print("User authorized notifications")
                        self?.getNotificationSettings()
                    } else {
                        //User did not authorize notifications
                        print("User did not authorize notifications")
                        DispatchQueue.main.async {
                            self?.settingsAlert(title: "Notifications Are Needed", message: "We want to send you notifications so you can see if a friend of yours is in trouble.")
                        }
                    }
                    
            }
        } else {
            // Fallback on earlier versions
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) {
                    [weak self] granted, error in
                    
                    print("Permission granted: \(granted)")
                    if granted {
                        //User authorized notifications
                        print("User authorized notifications")
                        self?.getNotificationSettings()
                    } else {
                        //User did not authorize notifications
                        print("User did not authorize notifications")
                        DispatchQueue.main.async {
                            self?.settingsAlert(title: "Notifications Are Needed", message: "We want to send you notifications so you can see if a friend of yours is in trouble.")
                        }
                    }
            }
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func requestLocationServices() {
        locationManager.requestAlwaysAuthorization()
        locationInit = true
    }
    
    
    func settingsAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                    if self.count >= 2 {
                        self.segueToMapVC()
                    }
                })
            }
        }
        
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            if self.count >= 2 {
                self.segueToMapVC()
            }
        })
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}

extension AccessViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        if status == .authorizedAlways {
            //User authorized location services
            print("User authorized location services always")
            DispatchQueue.main.async {
                self.segueToMapVC()
            }
        } else if status == .authorizedWhenInUse {
            //User authorized location services
            print("User authorized location services when in use")
            DispatchQueue.main.async {
                self.segueToMapVC()
            }
        } else {
            //User did not authorize location services
            //Show user how to enable location services for the application
            if locationInit {
                print("User did not authorize location services")
                settingsAlert(title: "Location Services Are Needed", message: "You must turn on location services so we can send your location to your friends if you need help.")
            }
        }
    }
}
