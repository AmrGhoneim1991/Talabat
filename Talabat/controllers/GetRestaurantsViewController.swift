//
//  GetRestaurantsViewController.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/24/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MapKit
class GetRestaurantViewController : UIViewController , UICollectionViewDelegate{
    
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let url = "https://talabat.art4muslim.net/api/getResturants?langu=ar"
    
    var isGridFlowLayoutUsed: Bool = false {
        didSet {
            updateButtonAppearance()
        }
    }
    
    var gridFlowLayout = GridFlowLayout()
    var listFlowLayout = ListFlowLayout()
    
     var restaurants = [Restaurant]()
     let itemsToDisplay = ["1" , "2" , "3" , "4" , "5" , "6" , "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.collectionViewLayout = gridFlowLayout
        collectionView.dataSource = self
        isGridFlowLayoutUsed = true
        getRestaurantData(url: url)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateButtonAppearance() {
       
        
        let layout = isGridFlowLayoutUsed ? gridFlowLayout : listFlowLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    @IBAction func gridTapped(_ sender: UIButton) {
        isGridFlowLayoutUsed = true
    }
    
    @IBAction func listTapped(_ sender: UIButton) {
        isGridFlowLayoutUsed = false
    }
    
    @IBAction func restNameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToOrder", sender: self)
    }
    
    
    
    func getRestaurantData (url : String ){
        Alamofire.request(url, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                for item in dataJSON["return"].array ?? [] {
                    self.restaurants.append(Restaurant(data: item))
                }
                self.collectionView.reloadData()
            }else{
                print("error in getRestaurantData func\(response.result.error)")
            }
        }
    }
    
  
}
    

extension GetRestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: globalCell.self), for: indexPath) as! globalCell
        
        let index = indexPath.row
        cell.restaurantImage.kf.setImage(with: URL(string: restaurants[index].rest_img) )
        
        cell.restaurantType.text = restaurants[index].rest_type
        cell.restuarantName.setTitle(restaurants[index].rest_name, for: .normal)
        cell.cardView.setCardView(view: cell.cardView)
        let restuarntLocation = MKPointAnnotation()
        restuarntLocation.coordinate = CLLocationCoordinate2D(latitude: restaurants[index].latitude, longitude: restaurants[index].longitude)
        cell.restaurantLocationView.addAnnotation(restuarntLocation)
         
        return cell
        
    }
}
extension UIView {
    
    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 2.0
        view.layer.borderColor  =  UIColor.lightGray.cgColor
        view.layer.borderWidth = 2.0
        view.layer.shadowOpacity = 1.0
        view.layer.shadowColor =  UIColor.clear.cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOffset = CGSize(width:3, height: 3)
        view.layer.masksToBounds = true
        
    }
}
