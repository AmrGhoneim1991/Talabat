//
//  Order.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/27/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
class Order {
       
    var user_location : String
    let latitude : CLLocationDegrees
    let longitude : CLLocationDegrees
    let order_user : String
    var order_details = [OrderDetails]()
    
    init(data : JSON) {
    
    user_location = (data["user_location"].string ?? "")
    
    order_user = (data["order_user"].string ?? "")
           
    let locationArray = user_location.split{$0 == ","}.map(String.init)
    latitude = (Double(locationArray[0])) as! CLLocationDegrees
    longitude = (Double(locationArray[1].trimmingCharacters(in: .whitespaces))) as! CLLocationDegrees
    for item in data["order_details"].array ?? []{
    order_details.append(OrderDetails(data: item ))
    }
}
}

class OrderDetails {
    let prod_name : String
    let prod_quantity : String
    let prod_price : String
    let prod_image : String
    
    init(data : JSON) {
       prod_name = (data["prod_name"].string ?? "")
       prod_quantity = (data["prod_quantity"].string ?? "")
       prod_price = (data["prod_price"].string ?? "")
       prod_image = (data["prod_image"].string ?? "")
        
    }
   
}

