//
//  ViewController.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnAcceso: UIButton!
    @IBOutlet weak var userLoginTXT: UITextField!
    @IBOutlet weak var userPsswdTXT: UITextField!
    
    override func viewDidLoad() {
    self.hideKeyboardWhenTappedAround()
    // Do any additional setup after loading the view.
        
    super.viewDidLoad()
        
        textFiedlsRounded(for: userLoginTXT)
        textFiedlsRounded(for: userPsswdTXT)
        padding(for: userLoginTXT)
        padding(for: userPsswdTXT)
        confBtn()
        
    }
    
    //MARK: Llamada para notificar al controlador que la vista acaba de presentar sus subvistas configuradas
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confBtn()

    }
    
    //MARK: Función que cumple con el ciclo de vida de la aplicación
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
    }
    
    //MARK: Función que cumple con el ciclo de vida de la aplicación
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
    }
    
    //MARK: Función que cumple con el ciclo de vida de la aplicación
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
    }
    
    //MARK: Control para ejecutar la función de inicio de sesión
    @IBAction func loginBtn(_ sender: AnyObject) {
        
       loginGSM()
        
    }
 
    //MARK: Función para que el personal que atiende en los centros comerciales inicie sesión
    func loginGSM(){
        
        let url = URL(string: "http://api.mallconcierge.mx/API-movil/loginCC.php")!
        let body = "user=\(userLoginTXT.text!)&password=\(userPsswdTXT.text!)"
        
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
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
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else{
                        print ("Error de parsing")
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200"{
                        
                    print(json)
                        
                    UserDefaults.standard.set(parsedJSON["CCid"], forKey: "CCid")
                    UserDefaults.standard.set(parsedJSON["logoCC"], forKey: "logoUrlCC")
                    UserDefaults.standard.set(parsedJSON["CCColorForm"], forKey: "ccColorForm")
                    UserDefaults.standard.set(parsedJSON["cc_name"], forKey: "cc_name")
                    UserDefaults.standard.synchronize()
                        
                    let iDCC: String = UserDefaults.standard.string(forKey: "CCid")!
                    print("El ID del Centro Comercial es: ",iDCC)
                        
                        self.userLoginTXT.text = ""
                        self.userPsswdTXT.text = ""
                    
                    helper.instantiateViewController(identifier: "tabBarRoot", animated: true, by: self, completion: nil)
                        
                    }else if parsedJSON["status"] as! String == "404" || parsedJSON["status"] as! String == "401"{
                        
                        helper.showAlert(title: "Error", message: parsedJSON["message"] as! String, in: self)
                        
                    }
                   }catch{
                        
                        helper.showAlert(title: "Error", message: error.localizedDescription, in: self)
                        
                    }
            }
        }.resume()
        
    }
    
    //MARK: Indica a este objeto que se produjeron uno o más toques nuevos en una vista o ventana
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.view.endEditing(true)

    }
    
    //MARK: Configuración de los botones
    func confBtn(){
        
        btnAcceso.layer.cornerRadius = 15
        btnAcceso.layer.masksToBounds = true
        
    }
    
    //MARK: Configuración de los textfields
    func textFiedlsRounded(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    //MARK: Función para aplicar relleno en los textfields
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }

}

