//
//  MedicamentosTableViewController.swift
//  MediKit
//
//  Created by Administrador on 25/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class MedicamentosTableViewController: UITableViewController {
    var tableViewMedicamentoData = [Medicamento]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request(Constantes.BD_URL + "getMedicamentos").responseJSON { response in
            if response.response?.statusCode == Constantes.OK_STATUS_CODE {
                print(response)
                self.tableViewMedicamentoData = JSONParser.parse(medicamentosData: response.result.value)
                self.tableView.reloadData()
                
            }
            else{
                //self.present(StaticMethods.makeAlert(message: Constants.SERVER_CONNECT_ERROR_STRING), animated: true, completion: nil)
                print("Error")
            }
            
        }

    }
    func setTableView(_ medicamentoData: [Medicamento]){
        tableViewMedicamentoData = medicamentoData
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
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MedicamentosTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMedicamento", for: indexPath) as! MedicamentosTableViewCell
        let medicamento = self.tableViewMedicamentoData[(indexPath as NSIndexPath).row]
        cell.nombreMedicamento.text = medicamento.nombreComercial

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
        if segue.identifier == "showMedicamentoSegue"{
            let dvc = segue.destination as! MedicamentoViewController
            let indexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.medicamentoActual = self.tableViewMedicamentoData[(indexPath as NSIndexPath).row]
        }
    }
 

}
