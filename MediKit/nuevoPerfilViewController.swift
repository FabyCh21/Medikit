//
//  nuevoPerfilViewController.swift
//  MediKit
//
//  Created by administrador on 26/10/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Alamofire
import Speech

class nuevoPerfilViewController: UIViewController, UITextFieldDelegate,SFSpeechRecognizerDelegate {
    var currentPerfil : Perfil? = nil

    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var fechaNacimiento: UIDatePicker!
    @IBOutlet weak var botonGrabar: UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "es-ES"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield delegate
        self.nombreUsuario.delegate = self
        botonGrabar.isEnabled = false
        speechRecognizer.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.botonGrabar.isEnabled = isButtonEnabled
            }
        }
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.nombreUsuario.resignFirstResponder()
    }

    
    
    @IBAction func grabar(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            botonGrabar.isEnabled = false
            botonGrabar.setTitle("Grabando", for: .normal)
        } else {
            startRecording()
            botonGrabar.setTitle("Detener", for: .normal)
        }
    }
    func startRecording() {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                
                self.nombreUsuario.text = result?.bestTranscription.formattedString  //9
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.botonGrabar.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        nombreUsuario.text = "Di algo !!"
        
    }
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            botonGrabar.isEnabled = true
        } else {
            botonGrabar.isEnabled = false
        }
    }
    
    @IBAction func CrearPerfil(_ sender: AnyObject)
        {
            /*let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dddd = dateFormatter.string(from: fechaNacimiento.date)*/
            fechaNacimiento.datePickerMode = UIDatePickerMode.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let selectedDate = dateFormatter.string(from: fechaNacimiento.date)
            print(selectedDate)
            self.view.endEditing(true)
            
            let parameters: Parameters = ["usuarioId":Globals.instance.usuarioActual.id,"fechaDeNacimiento":selectedDate,"nombre": nombreUsuario.text!]
            
            if(nombreUsuario.text?.isEmpty == true){
                print("ERROR")
                let alert = UIAlertController(title: "Alerta", message: "Es necesario que coloque un nombre de usuario para el perfil", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let url = URL(string:Constantes.PERFIL)! //+ nombreUsuario.text! + dddd
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
                        let alert = UIAlertController(title: "Notificación", message: "Se ha creado correctamente el perfil", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.nombreUsuario.text = ""
                        self.fechaNacimiento.reloadInputViews()
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
