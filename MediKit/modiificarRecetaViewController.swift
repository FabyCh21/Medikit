//
//  modiificarRecetaViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class modiificarRecetaViewController: UIViewController {

    @IBOutlet weak var horaConsumo: UIDatePicker!
    @IBOutlet weak var presentacion: UIPickerView!
    @IBOutlet weak var nombreMedicamento: UISearchBar!
    @IBOutlet weak var cantidadDias: UITextField!
    @IBOutlet weak var cantMedicamento: UITextField!
    @IBOutlet weak var frecuencia: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func enfermedadCronica(_ sender: AnyObject) {
    }
    @IBAction func modificarReceta(_ sender: AnyObject) {
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
