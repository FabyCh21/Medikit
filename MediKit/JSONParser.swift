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
                Globals.instance.perfilLista.append(newPerfil)
                }
            }
        return perfilList
        }
    }
    
    public static func parsePerfil(perfilD data: Any?) -> Perfil {
        //print(data)
        //var usuario: Usuario? = nil
        print(data)
        let responseArray = JSON(data).arrayObject as! [[String:Any]]
        var nuevoPerfil : Perfil? = nil
        for stringUsuario in responseArray {
            let id = stringUsuario["_id"] as! String
            let opp = stringUsuario["usuarioId"] as! String
            let nombrePerfil = stringUsuario["nombre"] as! String
                        let fechaNacimiento = stringUsuario["fechaDeNacimiento"] as! String
            
            nuevoPerfil = Perfil(nombre: nombrePerfil, fechaDeNacimiento: fechaNacimiento, id: id)
        }
        return nuevoPerfil!
        
    }
    
    
    public static func parseMedicamento (medicamentosData data: Any?) -> [Medicamento] {
        var listaMedicamentos = [Medicamento]()
        do{
            let json = JSON(data)
            if let responseData = json.arrayObject{
                let responseArray = responseData as! [[String:AnyObject]]
                
                for medicamento in responseArray {
                    let idMedi = medicamento["_id"] as! String
                    let nombreComerciall = medicamento["nombreComercial"] as! String
                    let nombreGenericoo = medicamento["nombreGenerico"] as! String
                    let descripcionn = medicamento["descripcion"] as! String
                    let newMedicamento = Medicamento(idMedicamento: idMedi, nombreComercial: nombreComerciall, nombreGenerico: nombreGenericoo,descripcion: descripcionn)
                    listaMedicamentos.append(newMedicamento)
                    Globals.instance.ListaMedicamentos.append(newMedicamento)
                }
            }
            
        
        return listaMedicamentos
        }
        
        
    }
    public static func parseReceta (recetasData data: Any?) -> [Receta] {
        var listaRecetas = [Receta]()
        do{
            let json = JSON(data)
            if let responseData = json.arrayObject{
                let responseArray = responseData as! [[String:AnyObject]]
                
                for receta in responseArray {
                    let idReceta = receta["_id"] as! String
                    let perfilIdd = receta["perfilId"] as! String
                    let usuarioIdd = receta["usuarioId"] as! String
                    let medicamentoIdd = receta["medicamentoId"] as! String
                    let duracionConsumoo = receta["duracionConsumo"] as! Int
                    let cantConsumoo = receta["cantConsumo"] as! Int
                    let minutoss = receta["minutos"] as! Int
                    let horaConsumoo = receta["horaConsumo"] as! Int
                    let nombree = receta["nombre"] as! String
                    let frecuencia = receta["frecuencia"] as! Int
                    
                    
                    let newReceta = Receta(id: idReceta, idUsuario : usuarioIdd, idPerfil: perfilIdd, medicamentoId: medicamentoIdd, nombre : nombree,  horaConsumo : horaConsumoo, minutos: minutoss, cantConsumo: cantConsumoo,duracionConsumo: duracionConsumoo, frecuencia: frecuencia)
                    listaRecetas.append(newReceta)
                    Globals.instance.ListaRecetas.append(newReceta)
                }
            }
            return listaRecetas
        }
    }
    public static func parseUsuario(usuariosData data: Any?) -> Usuario {
        //print(data)
        //var usuario: Usuario? = nil
        print(data)
        let responseArray = JSON(data).arrayObject as! [[String:Any]]
        var nuevoUsuario : Usuario? = nil
        for stringUsuario in responseArray {
            let id = stringUsuario["_id"] as! String
            let nombreusuario = stringUsuario["displayName"] as! String
            let correoElectronico = stringUsuario["email"] as! String
            let contrasenna = stringUsuario["password"] as! String
            let activo = stringUsuario["activo"] as! Bool
            
            nuevoUsuario = Usuario(id: id, correoElectronico: correoElectronico, nombreUsuario: nombreusuario, contrasenna: contrasenna, activo: activo)
            
        }
        return nuevoUsuario!
        
    }
    
    public static func parsePresentacion (presentacionesData data: Any?) -> [Presentacion] {
        var listaPresentaciones = [Presentacion]()
        do{
            let json = JSON(data)
            if let responseData = json.arrayObject{
                let responseArray = responseData as! [[String:AnyObject]]
                
                for presentacion in responseArray {
                    let idPresentacion = presentacion["_id"] as! String
                    let nombrePresentacionn = presentacion["nombre"] as! String
                    let descripcionPresentacionn = presentacion["descripcion"] as! String
                    
                    
                    let newPresentacion = Presentacion(id: idPresentacion, nombrePresentacion : nombrePresentacionn, descripcionPresentacion : descripcionPresentacionn)
                    listaPresentaciones.append(newPresentacion)
                    Globals.instance.ListaPresentaciones.append(newPresentacion)
                }
            }
            return listaPresentaciones
        }
    }
    
    
}
