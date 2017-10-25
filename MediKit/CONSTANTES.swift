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
    static let ALL_PERFILES: String = BD_URL + "getperfiles"
    
    // MARK: Codigos de estado
    static let OK_STATUS_CODE: Int = 200
    static let INTERNAL_ERROR_STATUS_CODE: Int = 500
    
}
