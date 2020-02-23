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
    var addLocationButton : UIButton!
    var ProfButton : UIButton!
    var PindButton : UIButton!
    var HomeButton : UIButton!
    var backButton : UIButton!
    
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
        
        var bgColor : UIImageView
        bgColor = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        bgColor.image = UIImage(named:"bgcolor")
        bgColor.center.x = self.view.center.x
        self.view.addSubview(bgColor)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        self.view.addSubview(tableView)
        
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
        
        backButton = UIButton(frame: CGRect(x: -50, y: UIScreen.main.bounds.height * 0.04, width: 50, height: 50))
        backButton.setTitle("backarrow", for: .normal)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.center.x = self.view.center.x - 140
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        submitButton = UIButton(frame: CGRect(x: 100, y: UIScreen.main.bounds.height - UIScreen.main.bounds.height * 0.3, width: 200, height: 100))
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setImage(UIImage(named: "submitbutton"), for: .normal)
        submitButton.center.x = self.view.center.x
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        
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
    
    @objc func segueToAddInterestsVC() {
        let vc = AddInterestsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @objc func backAction(){
        let vc = MapViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
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
