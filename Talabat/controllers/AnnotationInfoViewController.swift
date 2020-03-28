//
//  AnnotationInfoViewController.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/27/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit

class AnnotationInfoViewController :  UIViewController {
    
    var order = [OrderDetails]()
    
    
    override func viewDidLoad() {
        print(order.count)
    }
    
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.details = self.order
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func directionButtonTapped(_ sender: UIButton) {
        let getOrder = getOrderViewController()
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
