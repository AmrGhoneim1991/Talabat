//
//  DetailsViewController.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/27/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import  Kingfisher
import Alamofire
import SwiftyJSON

class DetailsViewController: UITableViewController {
    
   
    var details = [OrderDetails]()
    let url = "https://talabat.art4muslim.net/api/getOrder?restId=3&langu=ar"
    
    override func viewDidLoad() {
        
//        getOrderDetails(url: url)
        print(details.count)
    }
    
//     func getOrderDetails (url : String ){
//           Alamofire.request(url, method: .post).responseJSON {
//               response in
//               if response.result.isSuccess {
//                   let dataJSON : JSON = JSON(response.result.value!)
//
//                   for item in dataJSON["return"].array ?? [] {
//                       self.orders.append(Order(data: item))
//            }
//
//                print(self.orders[2].order_details)
//               }else{
//                   print("error in getRestaurantData func\(response.result.error)")
//               }
//           }
//       }
    
}

extension DetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        let index = indexPath.row
        cell.orderNameLabel.text = details[index].prod_name
        cell.orderPriceLabel.text = "\(details[index].prod_price) LE"
        cell.orderQuantityLabel.text = details[index].prod_quantity
        cell.orderImageView.kf.setImage(with: URL(string: details[index].prod_image) )
        
        return cell
    }
}
