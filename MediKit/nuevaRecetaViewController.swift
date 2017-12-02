//
//  nuevaRecetaViewController.swift
//  MediKit
//
//  Created by administrador on 15/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire

class nuevaRecetaViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var tblView: UITableView!
    var medicamentos :[Medicamento] = []
    var medicamentosFilter :[Medicamento] = []
    var shouldShowSearchResults = false
    var searchController = UISearchController()
    @IBOutlet weak var pickerPresentacion: UIPickerView!
    var idMedicamentoSeleccionado = ""

    var currentReceta: Receta? = nil
    var cantDias : Int? = nil
    var pickerData = [Presentacion]()
    
    @IBOutlet weak var nombreReceta: UITextField!
    @IBOutlet weak var lblCantD: UILabel!
    @IBOutlet weak var frecuencia: UITextField!
    @IBOutlet weak var enfermedadCronica: UISwitch!
    @IBOutlet weak var horaConsumo: UIDatePicker!
    @IBOutlet weak var cantidadDias: UITextField!
    @IBOutlet weak var cantidadMedicamento: UITextField!
    var presentacionID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getJSON()
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
        searchController = UISearchController(searchResultsController:nil)
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "search here..."
        searchController.searchBar.sizeToFit()
        tblView.tableHeaderView=searchController.searchBar
        self.pickerPresentacion.delegate = self
        self.pickerPresentacion.dataSource = self
         self.pickerData = Globals.instance.ListaPresentaciones
        
       // self.cantidadDias.delegate = self
       // self.cantidadMedicamento.delegate = self
       // self.frecuencia.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nombreReceta.resignFirstResponder()
        self.frecuencia.resignFirstResponder()
        self.cantidadDias.resignFirstResponder()
        self.cantidadMedicamento.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].nombrePresentacion
    }
    
    func pickerView(_ pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        self.presentacionID = pickerData[row].id
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tblView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        medicamentosFilter = medicamentos.filter({(Medicamento)-> Bool in
            let medicText: NSString = Medicamento.nombreComercial as NSString
            return(medicText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        tblView.reloadData()
    }
    
    func getJSON(){
        Alamofire.request(Constantes.MEDICAMENTOS).responseJSON {
            responseData in
            if responseData.response?.statusCode == 200{
                let value = responseData.result.value
                self.medicamentos = JSONParser.parseMedicamento(medicamentosData: value)
            }
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults{
            return medicamentosFilter.count
        }
        else{
            return self.medicamentos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellMedicamento", for: indexPath) as! MedicamentosTableViewCell
        
        if shouldShowSearchResults {
          cell.nombreMedicamentoLabel.text = self.medicamentosFilter[indexPath.row].nombreGenerico
        }
        else{
            cell.nombreMedicamentoLabel.text = medicamentos[indexPath.row].nombreGenerico
        }
        
        return cell

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shouldShowSearchResults{
            idMedicamentoSeleccionado = medicamentosFilter[indexPath.row].idMedicamento
        }
        else{
            idMedicamentoSeleccionado = medicamentos[indexPath.row].idMedicamento
        }
        
        print(idMedicamentoSeleccionado)
    }
    @IBAction func enfermedadCronica(_ sender: AnyObject) {
        if(sender.isOn ==  true){
            cantDias = 5
            cantidadDias.isHidden = true
            lblCantD.isHidden = true
        }
        else{
            cantDias = Int(cantidadDias.text!)
            cantidadDias.isHidden = false
            lblCantD.isHidden = false
        }
        
    }
    @IBAction func agregarReceta(_ sender: AnyObject){
        let duracion :Int = Int(self.cantidadDias.text!)!
        let canitdadDeConsumo: Int = Int(self.cantidadMedicamento.text!)!
        let frecuenciaC: Int = Int(self.frecuencia.text!)!
        horaConsumo.datePickerMode = UIDatePickerMode.time
        let date = Date()
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hour = comp.hour!
        let minute = comp.minute!
        
        let parameters: Parameters = ["perfilId": Globals.instance.perfilActual.id,"usuarioId": Globals.instance.usuarioActual.id,"medicamentoId":idMedicamentoSeleccionado,"duracionConsumo":duracion,"cantConsumo":canitdadDeConsumo,"minutos":minute
            ,"horaConsumo":hour,"nombre": self.nombreReceta.text!, "frecuencia": frecuenciaC, "presentacion": presentacionID]
        
      //  (le falta la presentacion del medicamento, la frecuencia: se toma cada 2 horas
        
        if((idMedicamentoSeleccionado == "" )||(cantidadMedicamento.text! == "") || (self.cantidadDias.text == "") || (frecuencia.text! == "")){
            let alert = UIAlertController(title: "Alerta", message: "Es necesario que todos los espacios esten llenos para agregar la receta", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let url = URL(string:Constantes.RECETA)!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            do{
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            }
            catch{
            }
            urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
            Alamofire.request(urlRequest).responseJSON{
                response in
                if response.response?.statusCode == Constantes.OK_STATUS_CODE{
                    print(response.response?.statusCode)
                    let alert = UIAlertController(title: "Notificación", message: "Se ha creado correctamente la receta", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.cantidadDias.text! = ""
                    self.cantidadMedicamento.text! = ""
                    self.frecuencia.text! = ""
                    self.nombreReceta.text! = ""
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    print(response.response?.statusCode)
                    let alert = UIAlertController(title: "Alerta", message: "Lo sentimos un error a ocurrido, Intentelo más tarde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    

}
