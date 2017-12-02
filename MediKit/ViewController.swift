//
//  ViewController.swift
//  MediKit
//
//  Created by administrador on 14/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import Google
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var contrassenna: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var usuario : Usuario? = nil
    var listaUsuarios = [Usuario]()
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Usuario/Correo Electrónico", attributes: [NSForegroundColorAttributeName: UIColor.white])
        contrassenna.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.white])
        getJSON()
        getJSONRecetas()
        getJSONPerfiles()
        getJSONMedicamentos()
        var error : NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        if (error != nil) {
            print(error)
            return
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contrassenna.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    func getJSON(){
        Alamofire.request(Constantes.PRESENTACIONES).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                JSONParser.parsePresentacion(presentacionesData: value)
            }
            
        }
    }
    
    func getJSONRecetas(){
        Alamofire.request(Constantes.ALL_RECETAS).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                JSONParser.parseReceta(recetasData: value)
            }
            
        }
    }
    func getJSONPerfiles(){
        Alamofire.request(Constantes.ALL_PERFILES).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                JSONParser.parsePerfil(data: value)
            }
            
        }
    }
    
    func getJSONMedicamentos(){
        Alamofire.request(Constantes.MEDICAMENTOS).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                JSONParser.parseMedicamento(medicamentosData: value)
            }
            
        }
    }
    
    /* func getJSONPerfiles(){
     Alamofire.request(Constantes.PERFILESUSUARIO +  (Globals.instance.usuarioActual.id)).responseJSON {
     responseData in
     if responseData.response?.statusCode == 200{
     let value = responseData.result.value
     JSONParser.parsePerfil(data: value)
     
     }
     
     }
     }
     */
    @IBAction func entrar(_ sender: AnyObject) {
        if((validarDatosDeUsuario(correoElectronico: self.emailTextField.text!, contrasenna: contrassenna.text!))
            && (isValidEmail(testStr: emailTextField.text!)) && (esContrasennaValida(contrasenna: contrassenna.text!))){
            if(peticionInicioSesion(correoElestronico: emailTextField.text!, contrasenna: contrassenna.text!)){
                self.performSegue(withIdentifier: "vistaPrincipalSegue", sender: self)
            }
        }
    }
    
    func validarDatosDeUsuario(correoElectronico: String, contrasenna: String) -> Bool{
        if((correoElectronico == "") || (contrasenna == "")){
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
    
    
    func peticionInicioSesion(correoElestronico: String, contrasenna: String) -> Bool{
        
        let parameters : Parameters = ["email": correoElestronico, "password": contrasenna]
        let url = URL(string:Constantes.LOGIN)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        catch{
            
        }
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        var res = false
        Alamofire.request(urlRequest).responseJSON{
            response in
            if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                Globals.instance.usuarioActual = JSONParser.parseUsuario(usuariosData: response.data)
                res = true
                self.performSegue(withIdentifier: "irVistaPrincipalSegue", sender:self)
            }
            else {
                self.alerta(nombre: "Datos incorrectos", mensaje: "Los datos suministrados son incorrectos")
            }
        }
        return res
    }
    
    
    func alerta (nombre: String, mensaje: String){
        let refreshAlert = UIAlertController(title: nombre, message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    private func localLogin(nombreUsuario: String, completion: @escaping(Bool, String?, Usuario?) -> Void) {
        Alamofire.request(Constantes.USUARIO_ACTUAL+nombreUsuario).responseJSON {
            responseData in
            if responseData.response?.statusCode == Constantes.OK_STATUS_CODE{
                let value = responseData.result.value
                completion(true, nil, JSONParser.parseUsuario(usuariosData: value!))
            }
            else{
                completion(false,"Error usuario no encontrado", nil)
            }
            
        }
    }
    
    
    
    
    @IBAction func facebook(_ sender: AnyObject) {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController: nil) {
            result in
            switch result {
            case .failed(_):
                print("fallò el login")
            case .cancelled:
                self.performSegue(withIdentifier: "irVistaPrincipalSegue", sender: self)
                print("se cancelò el login")
                
            case .success(_, _, _):
                self.getFacebookUserInfo(fields: "id, first_name, last_name, email", completion: { success, message, data in
                    if success {
                        self.performSegue(withIdentifier: "vistaPrincipalSegue", sender: self)
                        print("login exitoso")
                        let fbID = "fb" + (data!["id"] as! String)
                        if (FBSDKAccessToken.current().tokenString == fbID) {
                            loginManager.logOut()
                        }
                        self.localLogin(nombreUsuario: fbID, completion: { success, message, user in
                            if success {
                                Globals.instance.usuarioActual = user!
                                
                            }
                            else {
                                
                                let parameters : Parameters = ["email": data!["first_name"] as! String, "displayName": fbID, "password": ""]
                                
                                let url = URL(string:Constantes.REGISTRO_URL)! //+ nombreUsuario.text! + dddd
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
                                        self.performSegue(withIdentifier: "vistaLoginSegue", sender: self)
                                    }
                                }
                            }
                        })
                    }
                    else {
                        print("concluido")
                    }
                })
            }
        }
    }
    private func getFacebookUserInfo(fields: String, completion: @escaping(Bool, String?, [String : Any]?) -> Void) {
        GraphRequest(graphPath: "me", parameters: ["fields": fields]).start { response, result in
            switch result {
            case .failed(_):
                completion(false, "Hubo un error en el request." ,nil)
            case .success(let graphResponse):
                completion(true, nil, graphResponse.dictionaryValue)
            }
        }
    }
    
    
    @IBAction func google(_ sender: AnyObject) {
        
    }
    
    
}
