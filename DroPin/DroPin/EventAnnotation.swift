//
//  EventAnnotation.swift
//  DroPin
//
//  Created by Max on 2/22/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class EventAnnotation : NSObject, MKAnnotation {
    
    let id : Int64?
    let type : Int?
    let committed : Int?
    let desc : String?
    let coordinate : CLLocationCoordinate2D
    let title : String?
    let userCommitted : Int?
    
    init(id : Int64, type : Int, committed : Int, desc : String, coordinate : CLLocationCoordinate2D, title : String, userCommitted : Int) {
        self.id = id
        self.type = type
        self.committed = committed
        self.desc = desc
        self.title = title
        self.coordinate = coordinate
        self.userCommitted = userCommitted
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var subtitle: String? {
        if let desc = desc {
            return desc
        } else {
            return "No description"
        }
    }
    
}
