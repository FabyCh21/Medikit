//
//  PerfilesTableViewController.swift
//  MediKit
//
//  Created by administrador on 24/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PerfilesTableViewController: UITableViewController {
    
    var tableViewPerfilData = [Perfil]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func getJSON(){
        Alamofire.request("https://medi-kit.herokuapp.com/api/getperfiles").responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.tableViewPerfilData = JSONParser.parsePerfil(data: value)
                self.tableView.reloadData()
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPerfilSegue" {
            let dvc = segue.destination as! PerfilViewController
            let indelPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.currentPerfil = self.tableViewPerfilData[(indelPath as NSIndexPath).row]
            
        }
    }
    

}
