//
//  ListaRegistrosVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import UIKit

class ListaRegistrosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var registrosLista = [Registros]()
    
    var IDUsuario: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    let iDCC: String = UserDefaults.standard.string(forKey: "CCid")!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "subir"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let fila = registrosLista[indexPath.row]
                let destino = segue.destination as! SubirRegistroVC
                destino.registrosASubir = fila
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return registrosLista.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecords", for: indexPath)
        let registro = registrosLista[indexPath.row]
        cell.textLabel?.text = registro.nombre
        cell.detailTextLabel?.text = registro.apellido
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          tableView.reloadData()
          mostrarRegistros()
        
        if registrosLista.isEmpty == true{
            
            tableView.isHidden = true
            
        }else{
            
            tableView.isHidden = false
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if registrosLista.isEmpty == true{
            
            tableView.isHidden = true
            
        }else{
            
            mostrarRegistros()
            tableView.reloadData()
            tableView.isHidden = false
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool){
        
        mostrarRegistros()
        tableView.reloadData()

    }
    
    @IBAction public func subirLote(_ sender: UIButton){
   
        subeLoteDoppler()
        registrosLista.removeAll()
        tableView.reloadData()
        
    }
    
    func subeLoteDoppler(){
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Subiendo registros"
        spinningActivity?.detailsLabelText = "un momento por favor"
        TableRecords.shared
        
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {
            
            let id = row[0]! as! Int64
            let nombre = row[1]! as! String
            let apellido = row[2]! as! String
            let genero = row[3]! as! String
            let edad = row[4]! as! String
            let colonia = row[5]! as! String
            let zip = row[6]! as! String
            let municipio = row[7]! as! String
            let ciudad = row[8]! as! String
            let mail = row[9]! as! String
            let cel = row[10]! as! String
            let event = row[11]! as! String
            
            let interes1 = row [12]! as! String
            let interes2 = row [13]! as! String
            let interes3 = row [14]! as! String
            let interes4 = row [15]! as! String
            let interes5 = row [16]! as! String
            let interes6 = row [17]! as! String
            let interes7 = row [18]! as! String
            let interes8 = row [19]! as! String
            
            let ccName: String = UserDefaults.standard.string(forKey: "cc_name")!
            
            let url = URL(string: "https://restapi.fromdoppler.com/accounts/hmachuca%40artzpedregal.mx/lists/28408286/subscribers?api_key=5EB743C95C8B5F0A40E787730FA53FF8")!
            
            let body =  "{  \n\"email\": \"\(mail)\",  \n\"fields\": [    \n{      \n\"name\": \"FIRSTNAME\",      \n\"value\": \"\(nombre)\"    \n},    \n{      \n\"name\": \"LASTNAME\",      \n\"value\": \"\(apellido)\"    \n} ,\n{      \n\"name\": \"RangoEdad\",      \n\"value\": \"\(edad)\"    \n},\n{      \n\"name\": \"Interes1\",      \n\"value\": \"\(interes1)\"    \n},\n{      \n\"name\": \"Interes2\",      \n\"value\": \"\(interes2)\"    \n},\n{      \n\"name\": \"Interes3\",      \n\"value\": \"\(interes3)\"    \n},\n{      \n\"name\": \"Interes4\",      \n\"value\": \"\(interes4)\"    \n},\n{      \n\"name\": \"Interes5\",      \n\"value\": \"\(interes5)\"    \n},\n{      \n\"name\": \"Interes6\",      \n\"value\": \"\(interes6)\"    \n},\n{      \n\"name\": \"Interes7\",      \n\"value\": \"\(interes7)\"    \n},\n{      \n\"name\": \"Interes8\",      \n\"value\": \"\(interes8)\"    \n},\n{      \n\"name\": \"CodigoPostal\",   \n\"value\": \"\(zip)\"    \n},\n{      \n\"name\": \"Ciudad\",      \n\"value\": \"\(ciudad)\"    \n},\n{      \n\"name\": \"Celular\",      \n\"value\": \"\(cel)\"    \n},\n{      \n\"name\": \"Genero\", \n\"value\": \"\(genero)\"    \n},\n{      \n\"name\": \"Colonia\",      \n\"value\": \"\(colonia)\"    \n},\n{      \n\"name\": \"Municipio\",      \n\"value\": \"\(municipio)\"    \n},\n{      \n\"name\": \"Evento\",      \n\"value\": \"\(event)\"  \n},\n{      \n\"name\": \"CentroComercial\",   \n\"value\": \"\(ccName)\"  \n}\n] }"
            
            var request = URLRequest(url: url,timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body.data(using: .utf8)
            request.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: request){(data, response, error) in
                
                DispatchQueue.main.async { [self] .indices
                    let helper = Helper()
                    if error != nil{
                        
                        helper.showAlert(title: "Error en el servidor", message: error!.localizedDescription, in: self)
                        return
                    }
                    
                    do{
                        guard let data = data else{
                            helper.showAlert(title: "Error de datos", message: error!.localizedDescription, in: self)
                            return
                        }
                        let json =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                        
                        
                        guard let parsedJSON = json else {
                            print("PARSING ERROR")
                            return
                        }
                        
                        if let response = response as? HTTPURLResponse, response.isResponseOK(){
                            
                            TableRecords.shared.borrar(ids: Int64(id))
 
                        }else{
                            if parsedJSON["message"] != nil{
                                let message = parsedJSON["message"] as! String
                                helper.showAlert(title: "Error registro usuario", message: message, in: self)
                            }
                        }
                        
                    }catch{
                        helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                    }
                    
                }
            }.resume()
            
            print("----INICIA REGISTRO----")
            print("Nombre: \(nombre)\t")
            print("Apellido: \(apellido)\t")
            print("Zip: \(zip)\t")
            print("Ciudad: \(ciudad)\t")
            print("Teléfono: \(cel)\t")
            print("Genero: \(genero)\t")
            print("Correo: \(mail)\t")
            print("Edad: \(edad)\t")
            print("Colonia: \(colonia)\t")
            print("Municipio: \(municipio)\t")
            print("----FINALIZA REGISTRO----\t")
            
            spinningActivity?.labelText = "Finalizando registros"
            spinningActivity?.detailsLabelText = "un momento más por favor"
            
        }
        
        spinningActivity?.hide(true)
        
    }
    
    /*
    func subeLote(){
         
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Subiendo registros"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))!{
            
            let id = row[0]! as! Int64
            let nombre = row[1]! as! String
            let apellido = row[2]! as! String
            let genero = row[3]! as! String
            let edad = row[4]! as! String
            let colonia = row[5]! as! String
            let zip = row[6]! as! String
            let municipio = row[7]! as! String
            let ciudad = row[8]! as! String
            let mail = row[9]! as! String
            let cel = row[10]! as! String
            let event = row[11]! as! String
            
            let interes1 = row [12]! as! String
            let interes2 = row [13]! as! String
            let interes3 = row [14]! as! String
            let interes4 = row [15]! as! String
            let interes5 = row [16]! as! String
            let interes6 = row [17]! as! String
            let interes7 = row [18]! as! String
            let interes8 = row [19]! as! String
            let cantIntrst = row[20]! as! String
            
            let url = URL(string: "http://api.mallconcierge.mx/API-movil/clientRegisterCC.php")!
            
            let body = "name=\(nombre)&lastname=\(apellido)&zip=\(zip)&city=\(ciudad)&cell=\(cel)&genre=\(genero)&mail=\(mail)&suburb=\(colonia)&town=\(municipio)&age=\(edad)&ccID=\(iDCC)&event=\(event)"
            
        
            var request = URLRequest(url: url)
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
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                        
                        guard let parsedJSON = json else {
                            print("PARSING ERROR")
                            return
                        }
                        
                        if parsedJSON["status"] as! String == "200"{
                            
                        IDUsuario = parsedJSON["IDUsuario"] as! String
                            
                        subeInteresCliente(interes1: interes1, interes2: interes2, interes3: interes3, interes4: interes4, interes5: interes5, interes6: interes6, interes7: interes7, interes8: interes8, cantIntrst: cantIntrst, IDUsuario: IDUsuario, idLocalUser: Int(id))
                        
     
                        }else{
                            if parsedJSON["message"] != nil{
                                let message = parsedJSON["message"] as! String
                                helper.showAlert(title: "Error registro usuario", message: message, in: self)
                            }
                        }
                    }catch{
                        helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                    }
                }
            }.resume()
            
            
            print("----INICIA REGISTRO----")
            print("Nombre: \(nombre)\t")
            print("Apellido: \(apellido)\t")
            print("Zip: \(zip)\t")
            print("Ciudad: \(ciudad)\t")
            print("Teléfono: \(cel)\t")
            print("Genero: \(genero)\t")
            print("Correo: \(mail)\t")
            print("Edad: \(edad)\t")
            print("Colonia: \(colonia)\t")
            print("Municipio: \(municipio)\t")
            print("----FINALIZA REGISTRO----\t")
            
            spinningActivity?.labelText = "Finalizando registros"
            spinningActivity?.detailsLabelText = "un momento más por favor"
             
        }
        
        spinningActivity?.hide(true)
        
    }

    */
    
    /*
    
    func subeInteresCliente(interes1: String, interes2: String, interes3: String, interes4: String, interes5: String, interes6: String, interes7: String, interes8: String, cantIntrst: String, IDUsuario: String, idLocalUser: Int){
      
        let url2 = URL(string: "http://api.mallconcierge.mx/API-movil/clientInterestsRegisterCC.php")!
        
        let bodyInterests = "interest1=\(interes1)&interest2=\(interes2)&interest3=\(interes3)&interest4=\(interes4)&interest5=\(interes5)&interest6=\(interes6)&interest7=\(interes7)&interest8=\(interes8)&cantIntrst=\(cantIntrst)&idRecordClient=\(IDUsuario)"
        
        var request2 = URLRequest(url: url2)
        request2.httpBody = bodyInterests.data(using: .utf8)
        request2.httpMethod = "POST"
        
        //Aquí estamos
        URLSession.shared.dataTask(with: request2) { (data2, response2, error2) in
            
            DispatchQueue.main.async {
                
                let helper = Helper()
                
                if error2 != nil{
                    
                    helper.showAlert(title: "Error en el servidor", message: error2!.localizedDescription, in: self)
                    return
                }
                do {
                    
                    guard let data2 = data2 else{
                        helper.showAlert(title: "Error de datos", message: error2!.localizedDescription, in: self)
                        return
                    }
                    let json = try JSONSerialization.jsonObject(with: data2, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else {
                        print("PARSING ERROR")
                        return
                        
                        
                    }
                    
                    let statusServer: String = parsedJSON["status"] as! String
                    
                    if parsedJSON["status"] as! String == "202"{
                        
                        var id = idLocalUser
   
                      //  print("Se ha subido al backend el usuario con ID Local: \(id) y se ha eliminado")
                        
                     TableRecords.shared.borrar(ids: Int64(idLocalUser))
 
                    }else{
                        if parsedJSON["message"] != nil{
                           
                            let message = parsedJSON["message"] as! String
                            helper.showAlert(title: "Error Intereses", message: message, in: self)
                        }
                    }
                    
                    
                    
                }catch{
                    helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                }
            }
        }.resume()



    }
     */
    
    func mostrarRegistros(){

        registrosLista.removeAll()
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {
            
            let id = row[0]! as! Int64
            let nombre = row[1]! as! String
            let apellido = row[2]! as! String
            let genero = row[3]! as! String
            let edad = row[4]! as! String
            let colonia = row[5]! as! String
            let zip = row[6]! as! String
            let municipio = row[7]! as! String
            let ciudad = row[8]! as! String
            let mail = row[9]! as! String
            let cel = row[10]! as! String
            let event = row[11]! as! String
            
            let interes1 = row [12]! as! String
            let interes2 = row [13]! as! String
            let interes3 = row [14]! as! String
            let interes4 = row [15]! as! String
            let interes5 = row [16]! as! String
            let interes6 = row [17]! as! String
            let interes7 = row [18]! as! String
            let interes8 = row [19]! as! String
            let cantInterest = row[20]! as! String
            
            let lista = Registros(id: id, nombre: nombre, apellido: apellido, genero: genero, edad: edad, colonia: colonia, zip: zip, municipio: municipio, ciudad: ciudad, mail: mail, cel: cel, event: event, interes1: interes1, interes2: interes2, interes3: interes3, interes4: interes4, interes5: interes5, interes6: interes6, interes7: interes7, interes8: interes8, cantInterest: cantInterest)
            
            self.registrosLista.append(lista)
            
         }
    }
    
    @IBAction func btnSalir(_ sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnActualiza(_ sender: UIButton){
        
        mostrarRegistros()
        tableView.reloadData()
        
    }

}
