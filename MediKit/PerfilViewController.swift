//
//  PerfilViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var fechaNacimiento: UIDatePicker!
    var currentPerfil : perfil?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func modificarPerfil(_ sender: AnyObject) {
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
