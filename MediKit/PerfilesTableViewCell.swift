//
//  PerfilesTableViewCell.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class PerfilesTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreUsuario: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    @IBAction func borrar(_ sender: AnyObject) {
        let listaPerfil = Globals.instance.perfilLista
        for perfil in listaPerfil{
            if(perfil.nombre == self.nombreUsuario.text){
                let url = URL(string:Constantes.PERFILDELETE + perfil.id)!
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "DELETE"
                do{
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: Parameters(), options: [])
                }
                catch{
                }
                urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
                print(url)
                Alamofire.request(urlRequest).responseJSON{
                    response in
                    if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                        print(response.response?.statusCode)
                        let alert = UIAlertController(title: "Alerta", message: "Perfil eliminado", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        //self.present(alert, animated: true, completion: nil)

                    }else{
                        print(response.response?.statusCode)
                        let alert = UIAlertController(title: "Alerta", message: "Un error ocurrió mientras se eliminaba el perfil, lo sentimos. Intente más tarde", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                      //  self.present(alert, animated: true, completion: nil)

                        
                        
                    }
                    
                }
                
            }
        }
    
        
    }
}



