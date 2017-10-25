//
//  Globals.swift
//  MediKit
//
//  Created by administrador on 24/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation
import Alamofire

class Globals{
    public static let instance = Globals()
    public var perfilLista: [Perfil]
    public var ListaMedicamentos: [Medicamento]
    
    public init(){
        self.perfilLista = [Perfil]()
        self.ListaMedicamentos = [Medicamento]()
    }
}
