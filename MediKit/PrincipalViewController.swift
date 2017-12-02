//
//  PrincipalViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire
class PrincipalViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableViewRecetaData = [Receta]()
    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var tblReceta: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblReceta.reloadData()
        tblReceta.delegate = self
        tblReceta.dataSource = self
        self.nombreUsuario.text = Globals.instance.usuarioActual.nombreUsuario
        self.correo.text = Globals.instance.usuarioActual.correoElectronico
        self.tableViewRecetaData = Globals.instance.ListaRecetas
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewRecetaData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReceta.dequeueReusableCell(withIdentifier: "cellPrincipal", for: indexPath) as! principalTableViewCell
        let receta = self.tableViewRecetaData[(indexPath as NSIndexPath).row]
        if receta.idUsuario == receta.idPerfil {
            let url = Constantes.GETUSUARIOID + (receta.idUsuario)
            Alamofire.request(url).responseJSON {
                responseData in
                if responseData.response?.statusCode == 200{
                    let value = responseData.result.value
                    cell.perfil.text! = JSONParser.parseUsuario(usuariosData: value).nombreUsuario
                }
            }
        }
        else {
            for perfil in Globals.instance.perfilLista {
                if perfil.id == receta.idPerfil{
                    cell.perfil.text! = perfil.nombre
                }
            }
        }
        for medicamento in Globals.instance.ListaMedicamentos {
            if medicamento.idMedicamento == receta.medicamentoId {
                cell.medicamento.text! = medicamento.nombreComercial
            }
        }
        cell.hora.text = String(receta.horaConsumo)
        return cell
    }
    
    /*  func hola(){
     let n = 0
     for x in Globals.instance.perfilLista{
     let receta = self.tableViewRecetaData[n]
     if (x.id == receta.idPerfil) {
     return x.nombre
     //cell.perfil.text  = Globals.instance.perfilLista[indexPath.row].nombre
     }
     }
     }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
