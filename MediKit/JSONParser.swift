//
//  JSONParser.swift
//  MediKit
//
//  Created by Administrador on 16/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import Foundation
import SwiftyJSON


struct JSONParser{

    static func parsePerfil(data: Any?) -> [Perfil]{
        
        var perfilList = [Perfil]()
        do {
            
            let json = JSON(data)
            if let responseData = json.arrayObject{
                let responseArray = responseData as! [[String:AnyObject]]
            
                for perfill in responseArray {
                    let nombreP = perfill["nombre"] as! String
                    let fechaDeNacimientoP = perfill["fechaDeNacimiento"] as! String
                    let idP = perfill["_id"] as! String
                
                    let newPerfil = Perfil(nombre: nombreP, fechaDeNacimiento: fechaDeNacimientoP,id: idP)
                perfilList.append(newPerfil)
                }
            
            }
        
        return perfilList
        }

    }
    
    public static func parse(medicamentosData data: Any?) -> [Medicamento] {
        var listMedicamentos = [Medicamento]()
        print(data)
        let responseArray = JSON(data).arrayObject as! [[String : AnyObject]]
        for stringMedicamento in responseArray {
            listMedicamentos.append(Medicamento(idMedicamento: stringMedicamento["_id"] as! String,nombreComercial: stringMedicamento["nombreComercial"] as! String,nombreGenerico: stringMedicamento["nombreGenerico"] as! String, descripcion: stringMedicamento["descripcion"] as! String))
            
        }
        return listMedicamentos
        
        
    }
    
    
}
