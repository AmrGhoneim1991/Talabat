//
//  GetOrderViewController.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/24/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON
import MapKit
import CoreLocation

class getOrderViewController : UIViewController {
    
    @IBOutlet weak var orderMapView: MKMapView!
    let url = "https://talabat.art4muslim.net/api/getOrder?restId=3&langu=ar"
    
    var orders = [Order]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        getOrder(url: url)
    }
    
    
    
    func getOrder (url : String ){
        Alamofire.request(url, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                
                for item in dataJSON["return"].array ?? [] {
                    self.orders.append(Order(data: item))
                }
               
//                for i in 1...self.orders.count {
//                self.addAnnotaions(lat: self.orders[i-1].latitude, long: self.orders[i-1].longitude , name: self.orders[i-1].order_user)
//
//                }
                for i in self.orders {
                    self.addAnnotaions(lat: i.latitude, long: i.longitude, name: i.order_user)
                    print("Latitude orders --\(i.latitude)")
                }
                
            }else{
                print("error in getRestaurantData func\(response.result.error)")
            }
        }
    }
    
    func addAnnotaions (lat : CLLocationDegrees , long : CLLocationDegrees , name : String) {
        let orderLocation = MKPointAnnotation()
        orderLocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        orderLocation.title = name
        
        orderMapView.addAnnotation(orderLocation)
        

         
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if !(annotation is MKUserLocation) {
//            orderLocation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
//
//            let rightButton = UIButton(type: .infoDark)
//            rightButton.tag = annotation.hash
//
//            orderLocation.animatesDrop = true
//            orderLocation.canShowCallout = true
//            orderLocation.rightCalloutAccessoryView = rightButton
//
//            return orderLocation
//        }else {
//            return nil
//        }
//        }
    }
    
    

    func showListView(locationX : CGFloat ,locationY: CGFloat , annotationView : UIView, latitude: Double, longitude: Double) {
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "AnnotationInfoViewController") as! AnnotationInfoViewController
        dvc.modalPresentationStyle = .popover
        dvc.popoverPresentationController?.sourceView = annotationView
        dvc.popoverPresentationController?.sourceRect = CGRect(x: locationX  , y: locationY  , width: 0, height: 0)
        dvc.popoverPresentationController?.delegate = self
        dvc.preferredContentSize = CGSize(width: 300, height: 180)
//                dvc.delegate = self
        dvc.popoverPresentationController?.permittedArrowDirections = .down
        dvc.popoverPresentationController?.backgroundColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.4196078431, alpha: 1)
        let _ = orders.map {
            if $0.latitude == latitude && $0.longitude == longitude{
              dvc.order = $0.order_details
                print("Show list FUnc  Latitude \($0.latitude)")
            }
            
        }
        self.present(dvc, animated: false, completion: nil)
        
    }
    
    
    
    
    
}

extension getOrderViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let reuseIdentifier = "MyIdenttifier"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.tintColor = .white                // do whatever customization you want
            annotationView?.canShowCallout = false            // but turn off callout
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("got tapped\(mapView.centerCoordinate.latitude)")
        guard let latitude = view.annotation?.coordinate.latitude else {return}
        guard let longitude = view.annotation?.coordinate.longitude else {return}
        showListView(locationX: view.centerOffset.x , locationY: view.centerOffset.y, annotationView: view, latitude: latitude, longitude: longitude)
        print("Map View Latitude \(view.annotation?.coordinate.latitude)")
        print(view.centerOffset.y)
    }
    
}

//Mark: - CLLoctionManager Delegate

extension getOrderViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocationData = locations.last {
            let myLatitude = myLocationData.coordinate.latitude
            let myLongitude = myLocationData.coordinate.longitude
            let myLocation = MKPointAnnotation()
                  myLocation.coordinate = CLLocationCoordinate2D(latitude: myLatitude, longitude:myLongitude)
                  myLocation.title = "My Location"
                  orderMapView.addAnnotation(myLocation)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension getOrderViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
