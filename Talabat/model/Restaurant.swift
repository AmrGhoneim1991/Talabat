//
//  Restaurant.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/26/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class Restaurant : Codable {
    let rest_name : String
    let rest_type : String
    let rest_img : String
    let rest_location : String
    let latitude : CLLocationDegrees
    let longitude : CLLocationDegrees
    init(data : JSON) {
        rest_name = (data["rest_name"].string ?? "")
        rest_type = (data["rest_type"].string ?? "")
        rest_img = (data["rest_img"].string ?? "")
        rest_location = (data["rest_location"].string ?? "")
        
        let locationArray = rest_location.split{$0 == ","}.map(String.init)
        latitude = (Double(locationArray[0])) as! CLLocationDegrees
        longitude = (Double(locationArray[1])) as! CLLocationDegrees
        
    }
    
    
    
}
