//
//  PerfilViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//




import UIKit
import Alamofire

class PerfilViewController: UIViewController {
    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var fechaNacimiento: UIDatePicker!
    
    var currentPerfil : Perfil?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreUsuario.text! = (currentPerfil?.nombre)!
        
        let str = currentPerfil?.fechaDeNacimiento
        let index = str?.index((str?.startIndex)!, offsetBy: 10)
        str?.substring(to: index!)
        
        let isoDate = (str?.substring(to: index!))!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: isoDate)!
        fechaNacimiento.date=date
        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nombreUsuario.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editarPerfil(_ sender: AnyObject) {
            fechaNacimiento.datePickerMode = UIDatePickerMode.date
            let nuevaFecha = DateFormatter()
            nuevaFecha.dateFormat = "dd MMM yyyy"
            let selectedDate = nuevaFecha.string(from: fechaNacimiento.date)
            print(selectedDate)
            
            
            
            self.view.endEditing(true)
            
            let parameters: Parameters = ["fechaDeNacimiento":selectedDate,"nombre": nombreUsuario.text!]
            
            if(nombreUsuario.text?.isEmpty == true){
                print("ERROR")
                let alert = UIAlertController(title: "Alerta", message: "Es necesario que coloque un nombre de usuario para el perfil", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else{
                let url = URL(string:Constantes.PERFILUPDATE + (currentPerfil?.id)!)!
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
                        let alert = UIAlertController(title: "Alerta", message: "Perfil modificado satisfacctoriamente", preferredStyle: UIAlertControllerStyle.alert)
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
