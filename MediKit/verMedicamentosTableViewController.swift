//
//  verTableViewController.swift
//  MediKit
//
//  Created by administrador on 13/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//



import UIKit
import Alamofire

class verMedicamentoTableViewController: UITableViewController {
    
    var tableViewMedicamentoData = [Medicamento]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONMedicamentos()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
    }
    
    func getJSONMedicamentos(){
        Alamofire.request(Constantes.MEDICAMENTOS).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.tableViewMedicamentoData = JSONParser.parseMedicamento(medicamentosData: value)
                self.tableView.reloadData()
            }
            
        }
    }

    func setTableView(_ medicamentoData: [Medicamento]){
        print(medicamentoData)
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
        
        return  self.tableViewMedicamentoData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> verMedicamentosTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMedicamento", for: indexPath) as! verMedicamentosTableViewCell
        let medicamento = self.tableViewMedicamentoData[(indexPath as NSIndexPath).row]
        cell.nomMedicamento.text = medicamento.nombreGenerico
        
        // Configure the cell...
        
        return cell
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowMedicamentoSegue" {
            let dvc = segue.destination as! medicamentoViewController
            let indelPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.currentMedicamento = self.tableViewMedicamentoData[(indelPath as NSIndexPath).row]
        }
    }
    
    
}
