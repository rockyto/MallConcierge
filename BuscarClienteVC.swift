//
//  BuscarClienteVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 18/03/21.
//

import UIKit

class BuscarClienteVC: UIViewController {
    
    
  
    @IBOutlet weak var campoBuscarCliente: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
    @IBAction func btnBusca(_ sender: AnyObject) {
        
       clienteBuscar()
        
    }
    
    func clienteBuscar(){
        let helper = Helper()
        if campoBuscarCliente.text != ""{
        
        let spinningActivity = MBProgressHUD.showAdded(to: navigationController?.view, animated: true)
        spinningActivity?.labelText = "Buscando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        let url = URL(string: "http://api.mallconcierge.mx/API-movil/findClientCC.php")!
        let body = "client=\(campoBuscarCliente.text!)"
        
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
               
                
                if error != nil{
                    
                    helper.showAlert(title: "Error en el servidor", message: error!.localizedDescription, in: self)
                    return
                    
                }
                do{
                    guard let data = data else{
                        
                        helper.showAlert(title: "Error de datos", message: error!.localizedDescription, in: self)
                        
                        return
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else{
                        print ("Error de parsing")
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200"{
                        
                    helper.showAlert(title: "Resultado", message: parsedJSON["message"] as! String, in: self)
        
                    }else if parsedJSON["status"] as! String == "404" || parsedJSON["status"] as! String == "401"{
                        
                        helper.showAlert(title: "Error", message: parsedJSON["message"] as! String, in: self)
                        
                    }
                   }catch{
                        
                        helper.showAlert(title: "Error", message: error.localizedDescription, in: self)
                        
                    }
            }
        }.resume()
        self.campoBuscarCliente.text = ""
        spinningActivity?.hide(true)
        }else{
            
            helper.showAlert(title: "Atención", message: "Campo de búsqueda vacío. Introduzca el correo electrónico del cliente", in: self)
            
        }

    }
    
    @IBAction func btnCerrar(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
