//
//  MapViewController.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var addLocationButton : UIButton!
    var mapView : MKMapView!
    var locationManager = CLLocationManager()
    var pressedID : Int64 = -1
    var HomeButton : UIButton!
    var PindButton : UIButton!
    var ProfButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    
    func initUI() {
        mapView = MKMapView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height * 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.95))
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        var navb : UIImageView
        navb = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.15, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.15));
        navb.image = UIImage(named:"Bar")
        navb.center.x = self.view.center.x
        self.view.addSubview(navb)
               
        self.view.backgroundColor = .black
        
        var smlogo : UIImageView
        smlogo = UIImageView(frame:CGRect(x: 0, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.15, width: UIScreen.main.bounds.height * 0.1, height: UIScreen.main.bounds.height * 0.1));
        smlogo.image = UIImage(named:"Bar Logo")
        smlogo.center.x = self.view.center.x
        self.view.addSubview(smlogo)
        
        addLocationButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.08, width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05))
        addLocationButton.setTitle("add location", for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.setImage(UIImage(named: "Add_Pins"), for: .normal)
        addLocationButton.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.19
        addLocationButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        self.view.addSubview(addLocationButton)
        
        ProfButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.079, width: UIScreen.main.bounds.height * 0.04, height: UIScreen.main.bounds.height * 0.05))
        ProfButton.setTitle("Profile", for: .normal)
        ProfButton.setTitleColor(.black, for: .normal)
        ProfButton.setImage(UIImage(named: "Me"), for: .normal)
        ProfButton.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.38
        ProfButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        self.view.addSubview(ProfButton)
        
        PindButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.08, width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05))
        PindButton.setTitle("MyPind", for: .normal)
        PindButton.setTitleColor(.black, for: .normal)
        PindButton.setImage(UIImage(named: "My Pin'd"), for: .normal)
        PindButton.center.x = self.view.center.x + UIScreen.main.bounds.width * 0.19
        PindButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        self.view.addSubview(PindButton)
        
        HomeButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.09, width: UIScreen.main.bounds.height * 0.1, height: UIScreen.main.bounds.height * 0.06))
        HomeButton.setTitle("Home", for: .normal)
        HomeButton.setTitleColor(.black, for: .normal)
        HomeButton.setImage(UIImage(named: "Home"), for: .normal)
        HomeButton.center.x = self.view.center.x - UIScreen.main.bounds.width * 0.38
        HomeButton.addTarget(self, action: #selector(HomeAction), for: .touchUpInside)
        self.view.addSubview(HomeButton)
        
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
        if let loc = manager.location {
            let distanceSpan = 3000
            
            if let coordinate = manager.location?.coordinate {
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(distanceSpan), longitudinalMeters: CLLocationDistance(distanceSpan))
                mapView.setRegion(region, animated: true)
            }
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(loc, completionHandler: { placemarks, error -> Void in
                
                if let placeMark = placemarks?.first {
                    if let state = placeMark.administrativeArea, let city = placeMark.locality {
                        
                        print(state)
                        print(city)
                        
                        let decoder = JSONDecoder()
                        var userId : Int64?
                        if let userData = UserDefaults.standard.object(forKey: "User") {
                           do {
                               let user = try decoder.decode(User.self, from: userData as! Data)
                               userId = user.id
                                let parameters : [String : Any] = [
                               
                                   "city" : city,
                                   "state" : state,
                                   "userId" : userId!
                               ]
                               
                               self.sendGetEventsPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/getEvents", parameters: parameters)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                            
                       
                    }
                }
                
            })
        } else {
            //error could not get location
        }
    }
    
    func sendGetEventsPost(url : String, parameters : [String : Any]) {
        locationManager.stopUpdatingLocation()
        
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
                                
                if responseString.contains("city") {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let events = try decoder.decode([Event].self, from: Data(responseString.utf8))
                        print(events)
                        self.addAnnotations(events: events)
                    } catch {
                        //Error getting the events
                        print(error.localizedDescription)
                    }
                    
                } else if responseString == "1" {
                    //no events in the area
                }
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
    
    func addAnnotations(events: [Event]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let nowStr = dateFormatter.string(from: Date())
        let now = dateFormatter.date(from: nowStr)
        for event in events {
            let date = dateFormatter.date(from: event.time)
            
            if let lat = Double(event.lat), let lon = Double(event.lon), let latDeg = CLLocationDegrees(exactly: lat), let lonDeg = CLLocationDegrees(exactly: lon), let now = now, let date = date {
                if now < date {
                    let annotation = EventAnnotation(id: event.id, type: 0, committed: event.numberCommitted, desc: "Need: " + String(event.numberNeeded) + ", " + event.descrip, coordinate: CLLocationCoordinate2D(latitude: latDeg, longitude: lonDeg), title: event.title, userCommitted: event.userCommitted, time: event.time)
                    mapView.addAnnotation(annotation)
                }
            }
            
        }
        
    }
    
    func reloadAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("ss")

        let identifier = "Annotation"
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "29")
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 500))
        
        if let annotation = annotation as? EventAnnotation {
            
            var descHeight = 0
            
            if let desc = annotation.desc {
                descHeight = Int(desc.height(withConstrainedWidth: 200, font: UIFont.systemFont(ofSize: 17)))
                
                let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: descHeight))
                descriptionLabel.text = desc
                descriptionLabel.textColor = .black
                descriptionLabel.numberOfLines = 0
                view.addSubview(descriptionLabel)
            }
            
            let committButton = UIButton(frame: CGRect(x: 0, y: descHeight, width: 100, height: 50))
            if let userCom = annotation.userCommitted {
                if userCom == 0 {
                    committButton.setTitle("commit", for: .normal)
                    committButton.backgroundColor = .green
                } else {
                    committButton.setTitle("uncommit", for: .normal)
                    committButton.backgroundColor = .red
                }
                
            }
            
            
            committButton.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
            view.addSubview(committButton)
            
            var numberCommitedLabel = UILabel(frame: CGRect(x: 120, y: descHeight, width: 50, height: 100))
            if let numCom = annotation.committed {
                numberCommitedLabel.text = String(numCom)
            }
            numberCommitedLabel.textColor = .red
            view.addSubview(numberCommitedLabel)
        }
        
        let views = ["snapshotView": view]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(250)]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(250)]", options: [], metrics: nil, views: views))
            
        annotationView.detailCalloutAccessoryView = view
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? EventAnnotation, let id = annotation.id {
            pressedID = id
        }
    }
    
    @objc func commitAction() {
        if pressedID != -1 {
            let decoder = JSONDecoder()
            var userId : Int64?
            if let userData = UserDefaults.standard.object(forKey: "User") {
               do {
                   let user = try decoder.decode(User.self, from: userData as! Data)
                   userId = user.id
            
                    let parameters : [String : Any] = [
                        "userId" : userId!,
                        "eventId" : pressedID
                    ]
                    sendCommitPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/addCommit", parameters: parameters)
                
               } catch {
                    //error getting user
                   print(error.localizedDescription)
               }
            }
        }
    }
    
    func sendCommitPost(url : String, parameters : [String : Any]) {
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
                        self.reloadAnnotations()
                    }
                } else if responseString == "1" {
                    //user already is commited so it will decommit
                    DispatchQueue.main.async {
                        self.reloadAnnotations()
                    }
                    
                }
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
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
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)

        return ceil(boundingBox.height)
    }
}
