//
//  modiificarRecetaViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class modiificarRecetaViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource  {
    var currentReceta : Receta?
    
    @IBOutlet weak var nombreRecetaTextField: UITextField!
    @IBOutlet weak var pickerMedicamentos: UIPickerView!
    @IBOutlet weak var pickerPresentacion: UIPickerView!
    @IBOutlet weak var usuarioRecetaTextField: UITextField!
    @IBOutlet weak var presentacionRecetaTextField: UITextField!
    @IBOutlet weak var cantidadRecetaTextField: UITextField!
    @IBOutlet weak var frecuenciaRecetaTextField: UITextField!
    @IBOutlet weak var pickerNotificacion: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreRecetaTextField.text! = (self.currentReceta?.nombre)!
        presentacionRecetaTextField.text! = String(describing: self.currentReceta!.duracionConsumo)
        frecuenciaRecetaTextField.text! = String(describing: self.currentReceta!.frecuencia)
        cantidadRecetaTextField.text! = String(describing: self.currentReceta!.cantConsumo)
        getUsuarioDeLaReceta()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nombreRecetaTextField.resignFirstResponder()
        self.usuarioRecetaTextField.resignFirstResponder()
        self.presentacionRecetaTextField.resignFirstResponder()
        self.cantidadRecetaTextField.resignFirstResponder()
        self.frecuenciaRecetaTextField.resignFirstResponder()
    }
    
    func getUsuarioDeLaReceta(){
        if(self.currentReceta?.idUsuario == self.currentReceta?.idPerfil){
            let url = Constantes.GETUSUARIOID + (self.currentReceta!.idUsuario)
            Alamofire.request(url).responseJSON {
                responseData in
                if responseData.response?.statusCode == 200{
                    let value = responseData.result.value
                    self.usuarioRecetaTextField.text! = JSONParser.parseUsuario(usuariosData: value).nombreUsuario
                }
            }
        }
        else {
            for perfil in Globals.instance.perfilLista {
                if perfil.id == self.currentReceta?.idPerfil{
                    self.usuarioRecetaTextField.text! = perfil.nombre
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // The number of columns of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return pickerData.count
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return pickerData[row].nombrePresentacion
        return ""
    }

    
}
