//
//  Event.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

class Event : Codable {
    var id : Int64 = -1
    var userId : Int64 = -1
    var numberNeeded : Int = -1
    var title : String = ""
    var lat : String = ""
    var lon : String = ""
    var city : String = ""
    var state : String = ""
    var descrip : String = ""
    var numberCommitted : Int = -1
    var userCommitted : Int = 0
}
