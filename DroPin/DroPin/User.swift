//
//  User.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

class User : Codable {
    var id : Int64 = -1
    var name : String = ""
    var phoneNumber : String = ""
    
    func decodeUser() -> User? {
        if let userData = UserDefaults.standard.object(forKey: "User") as? Data {
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            } else {
                print("Error decoding userData")
            }
        } else {
            //Error getting userData
            print("Error getting user data")
        }
        return nil
    }
}
