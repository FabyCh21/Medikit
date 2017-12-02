//
//  nuevoMedicamentoViewController.swift
//  MediKit
//
//  Created by administrador on 15/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class nuevoMedicamentoViewController: UIViewController , UITextFieldDelegate {
    var currentMedicamento : Perfil? = nil

    @IBOutlet weak var nombreComerciall: UITextField!
    @IBOutlet weak var descrip: UITextField!
    @IBOutlet weak var nombreGeneric: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nombreComerciall.delegate = self
        self.nombreGeneric.delegate = self
        self.descrip.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nombreComerciall.resignFirstResponder()
        self.descrip.resignFirstResponder()
        self.nombreGeneric.resignFirstResponder()
    }

    @IBAction func crearMedicamento(_ sender: AnyObject) {
        let parameters: Parameters = ["nombreComercial":nombreComerciall.text!,"nombreGenerico":nombreGeneric.text!,"descripcion": descrip.text!]
        if((nombreComerciall.text?.isEmpty == true) || (nombreGeneric.text?.isEmpty == true) || (descrip.text?.isEmpty == true)){
            let alert = UIAlertController(title: "Alerta", message: "Es necesario que todos los espacios esten llenos para agregar el medicamento", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let url = URL(string:Constantes.MEDICAMENTO)!
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
                    let alert = UIAlertController(title: "Notificación", message: "Se ha creado correctamente el medicamento", preferredStyle: UIAlertControllerStyle.alert)
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
    

}


        

        


        




    
