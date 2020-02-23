//
//  AddEventViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddEventViewController : UIViewController, CLLocationManagerDelegate {
    
    var eventNameField : UITextField!
    var numNeededField : UITextField!
    var submitButton : UIButton!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        initUI()
    }
    
    func initUI() {
        eventNameField = UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        eventNameField.placeholder = "Event name"
        eventNameField.textColor = .black
        self.view.addSubview(eventNameField)
        
        numNeededField = UITextField(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        numNeededField.placeholder = "Number needed"
        numNeededField.textColor = .black
        self.view.addSubview(numNeededField)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = manager.location {
            
            createEvent(location: loc)
            
            
        } else {
            //couldnt get location
            //Show error
        }
    }
    
    func createEvent(location: CLLocation) {
        if let eventName = eventNameField.text, let numNeeded = numNeededField.text, let userData = UserDefaults.standard.object(forKey: "User") {
            locationManager.stopUpdatingLocation()
            let decoder = JSONDecoder()
            var userId : Int64?
            do {
                let user = try decoder.decode(User.self, from: userData as! Data)
                userId = user.id
            } catch {
                print(error.localizedDescription)
            }
            
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
                
                if let placeMark = placemarks?.first {
                    if let state = placeMark.administrativeArea, let city = placeMark.locality, let userId = userId {
                        print(city)
                        print(state)
                        print(userId)
                        let parameters : [String : Any] = [
                            
                            "city" : city,
                            "state" : state,
                            "lon" : location.coordinate.longitude,
                            "lat" : location.coordinate.latitude,
                            "title" : eventName,
                            "numNeeded" : numNeeded,
                            "userId" : userId
                        ]
                        self.sendAddEventPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/addEvent", parameters: parameters)
                    }

                }
                
            })
            
            
            
        } else {
            //error getting values
        }
    }
    
    func sendAddEventPost(url : String, parameters : [String : Any]) {
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
                        self.segueToMapVC()
                    }
                } else {
                    //error making event
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
    
    
}
