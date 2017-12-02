//
//  nuevaPresentacionViewController.swift
//  MediKit
//
//  Created by administrador on 20/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class nuevaPresentacionViewController: UIViewController {
    
    @IBOutlet weak var nombrePresentacion: UITextField!
    @IBOutlet weak var descripcionPresentacion: UITextField!
    var currentPresentacion : Presentacion? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nombrePresentacion.resignFirstResponder()
        self.descripcionPresentacion.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nuevaPresentacion(_ sender: AnyObject) {
        
        let parameters: Parameters = ["nombre":nombrePresentacion.text!, "descripcion":descripcionPresentacion.text!]
        
        if(nombrePresentacion.text?.isEmpty == true){
            print("ERROR")
            let alert = UIAlertController(title: "Alerta", message: "Es necesario que coloque un nombre y descripcion para la presentación", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let url = URL(string:Constantes.PRESENTACION)!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            do{
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch{
            }
            urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
            Alamofire.request(urlRequest).responseJSON{
                response in
                if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                    print(response.response?.statusCode)
                    let alert = UIAlertController(title: "Notificación", message: "Se ha creado correctamente la presentacion", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    print(response.response?.statusCode)
                    let alert = UIAlertController(title: "Alerta", message: "Lo sentimos un error a ocurrido, Intentelo más tarde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
            }
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     if segue.identifier == "perfilCeldas" {
     let dvc = segue.destination as! PerfilesTableViewController
     
     
     }
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
