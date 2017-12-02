//  verPresentacionesTableViewController.swift
//  MediKit
///Users/Administrador/Desktop/Paola Chaves/MediKit/MediKit/verPresentacionTableViewController.swift
//  Created by administrador on 20/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class verPresentacionesTableViewController: UITableViewController {
    
    var tableViewPresentacionData = [Presentacion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
    }

    func getJSON(){
        Alamofire.request(Constantes.PRESENTACIONES).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.tableViewPresentacionData = JSONParser.parsePresentacion(presentacionesData: value)
                self.tableView.reloadData()
            }
            
        }
    }

    func setTableView(_ presentacionData: [Presentacion]){
        print(presentacionData)
        tableViewPresentacionData = presentacionData
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
        
        return  self.tableViewPresentacionData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> verPresentacionesTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPresentacion", for: indexPath) as! verPresentacionesTableViewCell
        let presentacion = self.tableViewPresentacionData[(indexPath as NSIndexPath).row]
        cell.nombrePresentacion.text = presentacion.nombrePresentacion
        cell.descripcion.text = presentacion.descripcionPresentacion
        
        // Configure the cell...
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPresentacionSegue" {
            let dvc = segue.destination as! modificarPresentacionViewController
            let indelPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.currentPresentacion = self.tableViewPresentacionData[(indelPath as NSIndexPath).row]
        }
    }
    
    
}
