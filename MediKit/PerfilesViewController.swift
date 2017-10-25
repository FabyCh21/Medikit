//
//  PerfilesViewController.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PerfilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let instance = Globals.instance
    var actualPerfil = [perfil]()

    @IBOutlet weak var tableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actualPerfil = instance.perfilLista
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
       // let navigationItem =  self.tabBarController?.navigationItem
        //navigationItem?.title = Constantes.actualPerfil
    }
    
        

        
        Alamofire.request("https://medi-kit.herokuapp.com/api/getperfiles", method: .get , encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                
                
                if let data = response.result.value{
                    
                    if  response.data != nil{
                        print("HOLA1")
                        
                        if let dictionaryArray = data as? Array<Dictionary<String, AnyObject?>> {
                            print("HOLA2")
                            if dictionaryArray.count > 0 {
                                print(dictionaryArray.count)
                                print("HOLA3")
                                
                                
                                for i in 0..<dictionaryArray.count{
                                    print("HOLAlllllllll")
                                    
                                    let Object = dictionaryArray[i]
                                    if let nombre = Object["nombre"] as? String{
                                        print("holal")
                                    }
                                }
                            }
                        }
                    }
                    print("Me cago en la puta")
                }
                else {
                    print("aqui")
                    let error = (response.result.value  as? [[String : AnyObject]])
                    print(error as Any)
                }
              
                
        }

        // Do any additional setup after loading the view.
    }
    
    func setTableView(_perfilData: [perfil]){
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
     
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewPerfilData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerfilesTableViewCell", for: indexPath)
        let perfil = self.tableViewPerfilData[(indexPath as NSIndexPath).row]
        cell.nombreUsuario?.text = perfil.nombre
        
        // Configure the cell...
        
        return cell
    }*/


}


    
    

   
