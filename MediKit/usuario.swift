//
//  Usuario.swift
//  MediKit
//
//  Created by administrador on 25/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation

public class Usuario {
    public let nombreUsuario: String
    public let correoElectronico: String
    public let  contrasenna: String
    public let  id : String
    
    public init(id: String, correoElectronico: String, nombreUsuario: String,  contrasenna: String){
        self.id = id
        self.nombreUsuario = nombreUsuario
        self.correoElectronico = correoElectronico
        self.contrasenna = contrasenna
    }
}
