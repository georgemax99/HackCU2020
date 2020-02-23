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
    var addLocationButton : UIButton!
    var ProfButton : UIButton!
    var PindButton : UIButton!
    var HomeButton : UIButton!
    var backButton : UIButton!
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
        
        var bgColor : UIImageView
        bgColor = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        bgColor.image = UIImage(named:"bgcolor")
        bgColor.center.x = self.view.center.x
        self.view.addSubview(bgColor)
        
        var textfieldn : UIImageView
        textfieldn = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.675, width: 170, height: 55));
        textfieldn.image = UIImage(named:"Title box (top left)-1")
        textfieldn.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.18
        self.view.addSubview(textfieldn)
        eventNameField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.675, width: 150, height: 55))
        eventNameField.placeholder = "Event name"
        eventNameField.textColor = .black
        eventNameField.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.18
        self.view.addSubview(eventNameField)
        
        
        var textfieldnum : UIImageView
               textfieldnum = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.675, width: 100, height: 55));
               textfieldnum.image = UIImage(named:"PPl needed box (top right)-1")
               textfieldnum.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.24
               self.view.addSubview(textfieldnum)
        numNeededField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.675, width: 90, height: 55))
        numNeededField.placeholder = "# needed"
        numNeededField.textColor = .black
        numNeededField.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.246
        self.view.addSubview(numNeededField)
       
        
        var textfielddesc : UIImageView
        textfielddesc = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.5, width: 300, height: 150));
        textfielddesc.image = UIImage(named:"Description box (bottom)-1")
        textfielddesc.center.x = self.view.center.x
        self.view.addSubview(textfielddesc)
        descriptionField = UITextView(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.5, width: 300, height: 150))
        descriptionField.textColor = .black
        descriptionField.delegate = self
        descriptionField.center.x = self.view.center.x
        self.view.addSubview(descriptionField)
        
        
        var timefield : UIImageView
        timefield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.5875, width: 150, height: 50));
        timefield.image = UIImage(named:"Time box (mid left)-1")
        timefield.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.2
        self.view.addSubview(timefield)
        timePicker = UIDatePicker(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.6, width: 150, height: 75))
        timePicker.datePickerMode = .time
        timePicker.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.2
        self.view.addSubview(timePicker)
        
        
        var typefield : UIImageView
        typefield = UIImageView(frame:CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.5875, width: 150, height: 50));
        typefield.image = UIImage(named:"Location box (mid right)-1")
        typefield.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.2
        self.view.addSubview(typefield)
        typePicker = UIPickerView()
        typePicker.delegate = self
        typeField = UITextField(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.6, width: 150, height: 75))
        typeField.inputView = typePicker
        typeField.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.24
        self.view.addSubview(typeField)
        
        
        submitButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.3, width: 200, height: 100))
        submitButton.setTitle("login", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.setImage(UIImage(named: "submitbutton"), for: .normal)
        submitButton.center.x = self.view.center.x
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        
        dismissPickerView()
        
        var icon : UIImageView
        icon = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.95, width: 175, height: 180));
        icon.image = UIImage(named:"plogo")
        icon.center.x = self.view.center.x
        self.view.addSubview(icon)
        
        var amazing : UIImageView
        amazing = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.8, width: 240, height: 20));
        amazing.image = UIImage(named:"Have something amazing in mind")
        amazing.center.x = self.view.center.x
        self.view.addSubview(amazing)
        
        var pin : UIImageView
        pin = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.75, width: 175, height: 50));
        pin.image = UIImage(named:"Add a Pin now")
        pin.center.x = self.view.center.x
        self.view.addSubview(pin)
        
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
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.08, width: 50, height: 50))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 140
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        
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
    
    @objc func backAction(){
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
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
