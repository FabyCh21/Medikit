//
//  verPresentacionesTableViewCell.swift
//  MediKit
//
//  Created by administrador on 20/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class verPresentacionesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombrePresentacion: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        // Configure the view for the selected state
    }

    @IBAction func borrarPresentacion(_ sender: AnyObject) {
        let listaPresentaciones = Globals.instance.ListaPresentaciones
        for presentacion in listaPresentaciones{
            if(presentacion.nombrePresentacion == self.nombrePresentacion.text){
                let url = URL(string:Constantes.PRESENTACIONDELETE + presentacion.id)!
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
                        let alert = UIAlertController(title: "Alerta", message: "Presentacion eliminada", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        //self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        print(response.response?.statusCode)
                        let alert = UIAlertController(title: "Alerta", message: "Un error ocurrió mientras se eliminaba la presentación, lo sentimos. Intente más tarde", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        //  self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }
                    
                }
                
            }
        }
        
    }
    
}
