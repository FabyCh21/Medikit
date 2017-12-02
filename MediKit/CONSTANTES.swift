//
//  CONSTANTES.swift
//  MediKit
//
//  Created by Administrador on 16/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation

struct Constantes {
    
    // MARK: URL Servicio Web
    static let BD_URL: String = "https://medi-kit.herokuapp.com/api/"
    static let LOGIN_URL: String = BD_URL + "signup"
    static let REGISTRO_URL: String = BD_URL + "signup"
    static let USUARIOS : String = "getusuarios"
    static let USUARIO_ACTUAL : String = "getusuarioId/"
    static let LOGIN: String = BD_URL + "signin"
    static let GETUSUARIOID : String = BD_URL + "getusuarioId/"
    //URL PERFILES
    static let ALL_PERFILES: String = BD_URL + "getperfiles"
    static let PERFIL: String = BD_URL + "postperfil"
    static let PERFILUPDATE: String = BD_URL + "putperfil/"
    static let PERFILDELETE: String = BD_URL + "deleteperfil/"
    static let PERFILESUSUARIO : String =  BD_URL + "getperfilesusuario/"
    static let GETPERFILID : String = BD_URL + "getperfilId/"
    //URL RECETA
    static let RECETA : String = BD_URL + "postreceta"
    static let ALL_RECETAS: String = BD_URL + "getrecetas"
    static let DELETERECETA: String = BD_URL + "deletereceta/"
    static let MODIFICARRECETA: String = BD_URL + "putreceta/"
    //URL MEDICAMENTO
    static let DELETEMEDICAMENTO: String = BD_URL + "deletemedicamento/"
    static let MEDICAMENTOS: String = BD_URL + "getmedicamentos"
    static let MEDICAMENTOUPDATE: String = BD_URL + "putmedicamento/"
    static let MEDICAMENTO: String = BD_URL + "postmedicamento"
    //URL PRESENTACIONES
    static let PRESENTACIONES: String = BD_URL + "getpresentaciones"
    static let PRESENTACION: String = BD_URL + "postpresentacion"
    static let PRESENTACIONUPDATE: String = BD_URL + "putpresentacion/"
    static let PRESENTACIONDELETE: String = BD_URL + "deletepresentacion/"
    // MARK: Codigos de estado
    static let OK_STATUS_CODE: Int = 200
    static let INTERNAL_ERROR_STATUS_CODE: Int = 500
    
    var Usuario: Usuario? = nil
    
}
