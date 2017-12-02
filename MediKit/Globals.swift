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
    public var ListaRecetas: [Receta]
    public var usuarioActual: Usuario
    public var listaPerfilesDeUsuario = [Perfil]()
    public var perfilActual : Perfil
    public var ListaPresentaciones: [Presentacion]
    
    public init(){
        let usuario: Usuario = Usuario(id: "5a0de1b08e78dd00042fc5bf", correoElectronico: "gloriana@gmail.com", nombreUsuario: "Glory", contrasenna: "SDKNVKJSDVNKJSDVBSK", activo: true)
        let perfil: Perfil = Perfil(nombre: "Mariana", fechaDeNacimiento: "081094", id: "5a0de215b5625f0004769e03")
        self.perfilLista = [Perfil]()
        self.ListaMedicamentos = [Medicamento]()
        self.ListaRecetas = [Receta]()
        self.usuarioActual = usuario
        self.perfilActual = perfil
        self.ListaPresentaciones = [Presentacion]()
    }
}
