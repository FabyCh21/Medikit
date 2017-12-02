//
//  registroUsuarioTest.swift
//  MediKit
//
//  Created by Administrador on 14/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import XCTest
@testable import MediKit

class registroUsuarioTest: XCTestCase {
    var correoElectronico: String = "rogelio@gmail.com"
    var contrasenna : String = "123456789"
    var nombreUsuario : String = "Rojo"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
    func testUsuarioExisteRetornaTrue() {
        let view = ViewController()
        let resp = view.peticionInicioSesion(correoElestronico: self.correoElectronico, contrasenna: self.contrasenna)
        XCTAssertTrue(resp)
        
    }
    
    func testValidarCamposNoVaciosLogin(){
        let view = ViewController()
        let resp = view.validarDatosDeUsuario(correoElectronico: correoElectronico, contrasenna: contrasenna)
        XCTAssertTrue(resp)
    }
    
    func testvalidarCorreoYContrasennavalidosLogin(){
        let view = ViewController()
        let resp = view.isValidEmail(testStr: correoElectronico)
        let resp2 = view.esContrasennaValida(contrasenna: contrasenna)
        XCTAssertTrue(resp)
        XCTAssertTrue(resp2)
    }
    
    func testValidarCamposNoVaciosRegistro(){
        let view = RegistroViewController()
        let resp = view.validarDatosDeUsuario(correoElectronico: correoElectronico, contrasenna: contrasenna, nombreDeUsuario: nombreUsuario)
        XCTAssertTrue(resp)
    }
    
    func testvalidarCorreoYContrasennavalidosRegistro(){
        let view = RegistroViewController()
        let resp = view.isValidEmail(testStr: correoElectronico)
        let resp2 = view.esContrasennaValida(contrasenna: contrasenna)
        XCTAssertTrue(resp)
        XCTAssertTrue(resp2)
    }
    
    
}

