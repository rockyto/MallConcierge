//
//  SubirRegistroVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import UIKit

class SubirRegistroVC: UIViewController {
    
    var IDUsuario: String = ""
    
    var nombre = ""
    var apellido = ""
    var genero = ""
    var edad = ""
    var colonia = ""
    var zip = ""
    var municipio = ""
    var ciudad = ""
    var mail = ""
    var cel = ""
    
    var ccName: String = UserDefaults.standard.string(forKey: "cc_name")!
    
    var registrosASubir : Registros!

    @IBOutlet weak var btnSi: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnEliminar: UIButton!
    
    let iDCC: String = UserDefaults.standard.string(forKey: "CCid")!
    
    override func viewDidLoad() {
        
        botonesRedondos(for: btnSi)
        botonesRedondos(for: btnNo)
        botonesRedondos(for: btnEliminar)
        
        print("----Datos obligatorios----")
        print("IDRegistro: \(registrosASubir.id)")
        print("Nombre: \(registrosASubir.nombre)\t")
        print("Apellido: \(registrosASubir.apellido)\t")
        print("Zip: \(registrosASubir.zip)\t")
        print("Ciudad: \(registrosASubir.ciudad)\t")
        print("Teléfono: \(registrosASubir.cel)\t")
        print("Genero: \(registrosASubir.genero)\t")
        print("Correo: \(registrosASubir.mail)\t")
        print("----Datos no obligatorios----")
        print("Edad: \(registrosASubir.edad)\t")
        print("Colonia: \(registrosASubir.colonia)\t")
        print("Municipio: \(registrosASubir.municipio)\t")
        print(": \(registrosASubir.interes1)")
        print(": \(registrosASubir.interes2)")
        print(": \(registrosASubir.interes3)")
        print(": \(registrosASubir.interes4)")
        print(": \(registrosASubir.interes5)")
        print(": \(registrosASubir.interes6)")
        print(": \(registrosASubir.interes7)")
        print(": \(registrosASubir.interes8)")
        print(": \(registrosASubir.cantInterest)")
       
        
        super.viewDidLoad()
        print(registrosASubir!)
        // Do any additional setup after loading the view.
    }
    
    func botonesRedondos(for view: UIView){
         
         view.layer.cornerRadius = 15
         view.layer.masksToBounds = true
         
     }
    
    
    @IBAction func subeRegistro_clicked(_ sender: UIButton) {
        SubeRegistro()
    }
    
    func SubeRegistro(){
       
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Subiendo registro"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        let url = URL(string: "https://restapi.fromdoppler.com/accounts/hmachuca%40artzpedregal.mx/lists/28408286/subscribers?api_key=5EB743C95C8B5F0A40E787730FA53FF8")!
        
        
        let body =  "{  \n\"email\": \"\(registrosASubir.mail)\",  \n\"fields\": [    \n{      \n\"name\": \"FIRSTNAME\",      \n\"value\": \"\(registrosASubir.nombre)\"    \n},    \n{      \n\"name\": \"LASTNAME\",      \n\"value\": \"\(registrosASubir.apellido)\"    \n} ,\n{      \n\"name\": \"RangoEdad\",      \n\"value\": \"\(registrosASubir.edad)\"    \n},\n{      \n\"name\": \"Interes1\",      \n\"value\": \"\(registrosASubir.interes1)\"    \n},\n{      \n\"name\": \"Interes2\",      \n\"value\": \"\(registrosASubir.interes2)\"    \n},\n{      \n\"name\": \"Interes3\",      \n\"value\": \"\(registrosASubir.interes3)\"    \n},\n{      \n\"name\": \"Interes4\",      \n\"value\": \"\(registrosASubir.interes4)\"    \n},\n{      \n\"name\": \"Interes5\",      \n\"value\": \"\(registrosASubir.interes5)\"    \n},\n{      \n\"name\": \"Interes6\",      \n\"value\": \"\(registrosASubir.interes6)\"    \n},\n{      \n\"name\": \"Interes7\",      \n\"value\": \"\(registrosASubir.interes7)\"    \n},\n{      \n\"name\": \"Interes8\",      \n\"value\": \"\(registrosASubir.interes8)\"    \n},\n{      \n\"name\": \"CodigoPostal\",   \n\"value\": \"\(registrosASubir.zip)\"    \n},\n{      \n\"name\": \"Ciudad\",      \n\"value\": \"\(registrosASubir.ciudad)\"    \n},\n{      \n\"name\": \"Celular\",      \n\"value\": \"\(registrosASubir.cel)\"    \n},\n{      \n\"name\": \"Genero\", \n\"value\": \"\(registrosASubir.genero)\"    \n},\n{      \n\"name\": \"Colonia\",      \n\"value\": \"\(registrosASubir.colonia)\"    \n},\n{      \n\"name\": \"Municipio\",      \n\"value\": \"\(registrosASubir.municipio)\"    \n},\n{      \n\"name\": \"Evento\",      \n\"value\": \"\(registrosASubir.event)\"  \n},\n{      \n\"name\": \"CentroComercial\",   \n\"value\": \"\(ccName)\"  \n}\n] }"
        
        print(body)
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async { [self] in
                
                let helper = Helper()
                
                if error != nil{
                    
                    helper.showAlert(title: "Error en el servidor", message: error!.localizedDescription, in: self)
                    return
                }
                do {
                    
                    guard let data = data else{
                        helper.showAlert(title: "Error de datos", message: error!.localizedDescription, in: self)
                        return
                    }
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else {
                        print("PARSING ERROR")
                        return
                    }
                    
                    if let response = response as? HTTPURLResponse, response.isResponseOK(){
                        
                        print(json!)
                        helper.showAlert(title: "Atención", message: "Datos registrados", in: self)
                        self.EliminarRegistro()
                        
                        
                    }else{
                        
                        let message = parsedJSON["title"] as! String
                        helper.showAlert(title: "Error", message: message, in: self)
                    }

                }catch{
                    helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                }
            }
        }.resume()
        
        spinningActivity?.hide(true)
        
    }
    
    
    func EliminarRegistro(){
        
        TableRecords.shared.borrar(ids: registrosASubir.id)
        
    }
    

    
    @IBAction func eliminaRegistro_clicked(_sender: UIButton){
        
        let myAlert = UIAlertController(title: "Registro eliminado", message: "Todos los datos de este registro han sido eliminados", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alertAction) in
            
            self.EliminarRegistro()
            self.navigationController?.popViewController(animated: true)

                               })
                               
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil)
                            
        EliminarRegistro()
        
    }

}
