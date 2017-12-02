//
//  RegistroViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class RegistroViewController: UIViewController {
    @IBOutlet weak var correoElectronico: UITextField!
    @IBOutlet weak var nombreaUsuario: UITextField!
    @IBOutlet weak var contrasenna: UITextField!
    @IBOutlet weak var fechaDeNacimiento: UIDatePicker!
    var perfiles : [Perfil] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contrasenna.resignFirstResponder()
        self.correoElectronico.resignFirstResponder()
        self.nombreaUsuario.resignFirstResponder()
    }
    
    func alerta (nombre: String, mensaje: String){
        let refreshAlert = UIAlertController(title: nombre, message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func validarDatosDeUsuario(correoElectronico: String, contrasenna: String, nombreDeUsuario: String) -> Bool{
        if((correoElectronico == "") || (contrasenna == "") || (nombreDeUsuario == "")){
            alerta(nombre: "Datos incompletos", mensaje: "Debe llenar ambos campos")
            return false
        }
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func esContrasennaValida(contrasenna: String)-> Bool {
        if((contrasenna.characters.count) < 8 || (contrasenna.characters.count) >= 15){
            alerta(nombre: "Contraseña incorrecta", mensaje: "Debe estar en un rango de 8 a 15 caracteres")
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registrarse(_ sender: AnyObject) {
        if(validarDatosDeUsuario(correoElectronico: correoElectronico.text!, contrasenna: contrasenna.text!, nombreDeUsuario: nombreaUsuario.text!) && (isValidEmail(testStr: correoElectronico.text!)) && (esContrasennaValida(contrasenna: contrasenna.text!))) {
            let nombre: String = self.nombreaUsuario.text!
            let contra: String = self.contrasenna.text!
            let correo: String = self.correoElectronico.text!
            
            let parameters : Parameters = ["email": correo, "displayName": nombre, "password": contra]
            
            let url = URL(string:Constantes.REGISTRO_URL)! //+ nombreUsuario.text! + dddd
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            do{
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch{
            }
            urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
            nombreaUsuario.text = ""
            contrasenna.text = ""
            correoElectronico.text = ""
            Alamofire.request(urlRequest).responseJSON{
                response in
                if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                    self.performSegue(withIdentifier: "vistaLoginSegue", sender: self)
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
