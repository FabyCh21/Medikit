//
//  PerfilesTableViewController.swift
//  MediKit
//
//  Created by administrador on 24/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class PerfilesTableViewController: UITableViewController {
    
    var tableViewPerfilData = [Perfil]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        getJSONPerfiles()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       
    }
    func getJSONPerfiles(){
        Alamofire.request(Constantes.ALL_PERFILES).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.tableViewPerfilData =  JSONParser.parsePerfil(data: value)
                self.tableView.reloadData()
            }
            
        }
    }
    
    func getJSON(){
        Alamofire.request(Constantes.PERFILESUSUARIO +  (Globals.instance.usuarioActual.id)).responseJSON {
            responseData in
            if responseData.response?.statusCode == Constantes.OK_STATUS_CODE{
                let value = responseData.result.value
            }
           
        }
    }
    func setTableView(_ perfilData: [Perfil]){
        print(perfilData)
        tableViewPerfilData = perfilData
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return  self.tableViewPerfilData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PerfilesTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPerfil", for: indexPath) as! PerfilesTableViewCell
        let perfil = self.tableViewPerfilData[(indexPath as NSIndexPath).row]
        cell.nombreUsuario.text = perfil.nombre

        // Configure the cell...

        return cell
    }
    
    
    
  

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPerfilSegue" {
            let dvc = segue.destination as! PerfilViewController
            let indelPath = self.tableView.indexPathForSelectedRow! as IndexPath
            Globals.instance.perfilActual = self.tableViewPerfilData[(indelPath as NSIndexPath).row]
            dvc.currentPerfil = self.tableViewPerfilData[(indelPath as NSIndexPath).row]
        }
    }
    

}
