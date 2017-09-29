//
//  ViewController.swift
//  MediKit
//
//  Created by administrador on 14/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioTextField.attributedPlaceholder = NSAttributedString(string: "Usuario/Correo Electrónico", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        contraseñaTextField.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
       
    }
    
    @IBAction func entrar(_ sender: AnyObject) {
    }
    
    @IBAction func facebook(_ sender: AnyObject) {
    }
    @IBAction func google(_ sender: AnyObject) {
    }
    

}  
