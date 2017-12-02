//
//  verRecetaTableViewController.swift
//  MediKit
//
//  Created by administrador on 16/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class verRecetaTableViewController: UITableViewController {
    var tableViewRecetaData = [Receta]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONRecetas()
        
    }

    func setTableView(_ recetaData: [Receta]){
        tableViewRecetaData = recetaData
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJSONRecetas(){
        Alamofire.request(Constantes.ALL_RECETAS).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.tableViewRecetaData = JSONParser.parseReceta(recetasData: value)
                self.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  self.tableViewRecetaData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RecetasTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "recetaCell", for: indexPath) as! RecetasTableViewCell
        let receta = self.tableViewRecetaData[(indexPath as NSIndexPath).row]
        cell.nombreReceta.text = receta.nombre
        
        // Configure the cell...
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowRecetaSegue" {
            let dvc = segue.destination as! modiificarRecetaViewController
            let indelPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.currentReceta = self.tableViewRecetaData[(indelPath as NSIndexPath).row]
        }
    }

   

}



    
    

