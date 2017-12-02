//
//  verMedicamentoTableViewCell.swift
//  MediKit
//
//  Created by administrador on 13/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class verMedicamentosTableViewCell: UITableViewCell {

    @IBOutlet weak var nomMedicamento: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func borrarMedicamento(_ sender: AnyObject) {
        var listaMedicamentos = Globals.instance.ListaMedicamentos
        for medicamento in listaMedicamentos{
            if(medicamento.nombreGenerico == self.nomMedicamento.text){
                let url = URL(string:Constantes.DELETEMEDICAMENTO + medicamento.idMedicamento)!
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "DELETE"
                do{
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: Parameters(), options: [])
                }
                catch{
                }
                urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
                Alamofire.request(urlRequest).responseJSON{
                    response in
                    if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                        print(response.response?.statusCode)
                        let alert = UIAlertController(title: "Alerta", message: "Medicamento eliminado", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        //self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        print(response.response?.statusCode)
                        let alert = UIAlertController(title: "Alerta", message: "Un error ocurrió mientras se eliminaba el medicamento, lo sentimos. Intente más tarde", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        //  self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }
                    
                }
                
            }
        }
        
        
    }

    
   
    }




