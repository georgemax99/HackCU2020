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

class MapViewController : UIViewController, CLLocationManagerDelegate {
    
    var addLocationButton : UIButton!
    var mapView : MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func initUI() {
        addLocationButton = UIButton(frame: CGRect(x: 100, y: 0, width: 200, height: 100))
        addLocationButton.setTitle("add location", for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        self.view.addSubview(addLocationButton)
        
        mapView = MKMapView(frame: CGRect(x: 0, y: 150, width: 300, height: 300))
        self.view.addSubview(mapView)
        
        self.view.backgroundColor = .white
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
        if let loc = manager.location {
            let distanceSpan = 1500
            
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
                        let parameters : [String : Any] = [
                        
                            "city" : city,
                            "state" : state
                        ]
                        
                        self.sendGetEventsPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/getEvents", parameters: parameters)
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
        for event in events {
            let annotation = MKPointAnnotation()
            annotation.title = event.title
            if let lat = Double(event.lat), let lon = Double(event.lon), let latDeg = CLLocationDegrees(exactly: lat), let lonDeg = CLLocationDegrees(exactly: lon) {
                annotation.coordinate = CLLocationCoordinate2D(latitude: latDeg, longitude: lonDeg)
                mapView.addAnnotation(annotation)
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    @objc func addLocationAction() {
        let vc = AddEventViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
}
