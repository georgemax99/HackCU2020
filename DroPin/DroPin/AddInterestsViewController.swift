//
//  AddInterests.swift
//  DroPin
//
//  Created by Max on 2/23/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit

class AddInterestsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    var submitButton : UIButton!
    
    let types = ["Misc", "Basketball", "Soccer", "Frisbee", "Studying", "Gym", "Party", "Skating", "Snowboarding / Skiing", "Video Games"]
    
    var selectedTypes : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initUI()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTypes()
    }
    func initUI() {
        
        submitButton = UIButton(frame: CGRect(x: 100, y: 0, width: 200, height: 100))
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    func getTypes() {
        let decoder = JSONDecoder()
        var userId : Int64?
        if let userData = UserDefaults.standard.object(forKey: "User") {
           do {
               let user = try decoder.decode(User.self, from: userData as! Data)
               userId = user.id
                let parameters : [String : Any] = [
                   "userId" : userId!
               ]
               
               self.sendGetTypesPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/getTypes", parameters: parameters)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendGetTypesPost(url : String, parameters : [String : Any]) {
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
                                
                if responseString.contains("type") {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        let types = try decoder.decode([Type].self, from: Data(responseString.utf8))
                        self.fillWithTypes(types: types)
                        
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
    
    func fillWithTypes(types : [Type]) {
        for type in types {
            self.selectedTypes.append(type.type)
        }
        print(selectedTypes)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    func segueToMapVC() {
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    func sendAddInterestsPost(url : String, parameters : [String : Any]) {
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
                    //error adding interests
                    DispatchQueue.main.async {
                        self.segueToMapVC()
                    }
                
                }
                print("responseString = \(responseString)")
            }
            
        }
        
        task.resume()
    }
    
    @objc func submitAction() {
        let decoder = JSONDecoder()
        var userId : Int64?
        if let userData = UserDefaults.standard.object(forKey: "User") {
            do {
                let user = try decoder.decode(User.self, from: userData as! Data)
                userId = user.id
                let parameters : [String : Any] = [
                    "userId" : userId!,
                    "types" : selectedTypes
                ]
                sendAddInterestsPost(url: "http://Dropin-env.b7vjewtmgu.us-east-1.elasticbeanstalk.com/addTypes", parameters: parameters)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = types[indexPath.row + 1]
        cell.textLabel?.textColor = .white
        
        if selectedTypes.contains(indexPath.row) {
            cell.backgroundColor = .green
            cell.textLabel?.textColor = .black
        } else {
            cell.backgroundColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTypes.contains(indexPath.row) {
            selectedTypes = selectedTypes.filter {$0 != indexPath.row}
        } else {
            selectedTypes.append(indexPath.row)
        }
        
        tableView.reloadData()
    }
    
    
}
