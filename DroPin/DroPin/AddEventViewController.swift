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

class AddEventViewController : UIViewController, CLLocationManagerDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var eventNameField : UITextField!
    var numNeededField : UITextField!
    var descriptionField : UITextView!
    var timePicker : UIDatePicker!
    var submitButton : UIButton!
    var typePicker : UIPickerView!
    var typeField : UITextField!
    var locationManager = CLLocationManager()
    var type = 0
    let types = ["Misc", "Basketball", "Soccer", "Frisbee", "Studying", "Gym", "Party", "Skating", "Snowboarding / Skiing", "Video Games"]
    
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
        
        descriptionField = UITextView(frame: CGRect(x: 100, y: 400, width: 200, height: 200))
        descriptionField.textColor = .black
        descriptionField.delegate = self
        self.view.addSubview(descriptionField)
        
        timePicker = UIDatePicker(frame: CGRect(x: 100, y: 600, width: 200, height: 100))
        timePicker.datePickerMode = .time
        self.view.addSubview(timePicker)
        
        typePicker = UIPickerView()
        typePicker.delegate = self
        typeField = UITextField(frame: CGRect(x: 100, y: 700, width: 200, height: 100))
        typeField.inputView = typePicker
        self.view.addSubview(typeField)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        dismissPickerView()
        
        self.view.backgroundColor = .white
    }
    
    @objc func submitAction() {
        
        if let eventName = eventNameField.text, let numNeeded = numNeededField.text {
            if eventName != "" && numNeeded != "" {
                locationManager.startUpdatingLocation()
            } else if eventName == "" && numNeeded == "" {
                //error both fields are empty
            } else if eventName == "" {
                //error event name is empty
            } else {
                //error num needed is empty
            }
        }
        
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
        if let eventName = eventNameField.text, let numNeeded = numNeededField.text, let userData = UserDefaults.standard.object(forKey: "User"), let desc = descriptionField.text {
            locationManager.stopUpdatingLocation()
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let time = timeFormatter.string(from: timePicker.date)
            
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
                            "userId" : userId,
                            "description" : desc,
                            "time" : time,
                            "type" : self.type
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.count
        return numberOfChars < 255
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       typeField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = row
        typeField.text = types[row]
    }
    
}
