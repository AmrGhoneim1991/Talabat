//
//  ViewController.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/24/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController : UIViewController , UITextFieldDelegate{
    
    let url = "https://talabat.art4muslim.net/api/login"
    @IBOutlet weak var PhoneNumberTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneNumberTextFiled.delegate = self
        passwordTextFiled.delegate = self
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let params : [String : String] = ["access_key" : "Gdka52DASWE3DSasWE742Wq" , "access_password" : "yH52dDDF85sddEWqPNV7D12sW5e" , "mobile" : PhoneNumberTextFiled.text! , "password" : passwordTextFiled.text!]
        
        if PhoneNumberTextFiled.text == "" || passwordTextFiled.text == "" {
            let alert = UIAlertController(title: "missing data", message: "please enter both phone number and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            login(url: url, paramaters: params)
            
             
            
        }


    }
    
    
    
    func login (url : String , paramaters : [String : String]){
        Alamofire.request(url, method: .post, parameters: paramaters , encoding: JSONEncoding.default).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                if dataJSON["status"] == 200 {
                    self.performSegue(withIdentifier: "goToRestaurant", sender: self)
                }else {
                    let alert = UIAlertController(title: "Invalid account", message: "invalid phone number or password", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }else{
                print("error in login func\(response.result.error)")
            }
        }
        
    }

    
    
    
    
}


