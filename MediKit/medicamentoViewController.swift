//
//  medicamentoViewController.swift
//  MediKit
//
//  Created by administrador on 13/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class medicamentoViewController: UIViewController {
    var currentMedicamento : Medicamento?
    @IBOutlet weak var descripcion: UITextField!
    @IBOutlet weak var nombreComercial: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreComercial.text! = (currentMedicamento?.nombreComercial)!
        descripcion.text! = (currentMedicamento?.descripcion)!
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.descripcion.resignFirstResponder()
        self.nombreComercial.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editarMedicamento(_ sender: AnyObject) {
        
        
        let parameters: Parameters = ["nombreComercial":nombreComercial.text!,"descripcion": descripcion.text!]
        
        if((nombreComercial.text?.isEmpty == true) || (descripcion.text?.isEmpty == true)){
            print("ERROR")
            let alert = UIAlertController(title: "Alerta", message: "Es necesario que coloque un nombre Comercial para el medicamento", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else{
            let url = URL(string:Constantes.MEDICAMENTOUPDATE + (currentMedicamento?.idMedicamento)!)!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
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
                    let alert = UIAlertController(title: "Alerta", message: "Medicamento modificado satisfacctoriamente", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    print(response.response?.statusCode)
                    let alert = UIAlertController(title: "Alerta", message: "Un error ocurrio en la ejecución del programa, Intente más tarde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
