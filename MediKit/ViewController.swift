//
//  ViewController.swift
//  MediKit
//
//  Created by administrador on 14/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioTextField.attributedPlaceholder = NSAttributedString(string: "Usuario/Correo Electrónico", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        contraseñaTextField.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.white])
       
    }
    @IBAction func entrar(_ sender: AnyObject) {
        // prepare json data
        /*let json: Parameters = ["email": "kimb.morales.arias@gmail.com",
                                   "displayName": "Kim",
                                   "password": "1239999999"]
        
        Alamofire.request(Constantes.BD_URL + Constantes.LOGIN_URL, method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseString { response in
                print(response)
        }*/
        
        /*guard let url = URL(string: Constantes.BD_URL + "getusers") else{
        return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                 let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
        }.resume()*/
        let parameters = ["email": "yettiavilagomez@hotmail.com",
                          "displayName": "Yei",
                          "password": "1234"]
        
        guard let url = URL(string: Constantes.BD_URL + "signup") else{ return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request){(data,response,error) in
            if let response = response{
                print(response)
            }
            if let data = data{
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }

            }
        }.resume()
        
        
        
    }
    
    @IBAction func facebook(_ sender: AnyObject) {
    }
    @IBAction func google(_ sender: AnyObject) {
        
    }
    

}  
