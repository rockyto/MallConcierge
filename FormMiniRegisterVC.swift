//
//  FormMiniRegisterVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 16/03/21.
//

import SQLite
import UIKit

struct Eventos: Decodable{
    let ccEventName: String
}

class FormMiniRegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var cantIntrst: Int = 0
    var cantidadIntereses:Int = 0
    var idRecordCC: Int = 0
    let helper = Helper()

    var currentTextField = UITextField()
    
    let dataSource = ["-Genero-", "Hombre", "Mujer", "Prefiero no decirlo"]
    let dataSourceAge = ["-Rango de edad-","15-25", "26-35", "36-45", "46-55", "56-65", "65 o más"]
    
    var arrayInterest = [String]()
    
    var eventos = [Eventos]()
    
    var generoPicker = UIPickerView()
    var rangoEdadPicker = UIPickerView()
    var eventoPicker = UIPickerView()
    
    //MARK: Declarando constraints
    @IBOutlet weak var personalData: NSLayoutConstraint!
    @IBOutlet weak var contactData: NSLayoutConstraint!
    @IBOutlet weak var footView: UIView!
    
    //MARK: Declarando views
    @IBOutlet weak var colorCCSlide1: UIView!
    @IBOutlet weak var colorCCSlide2: UIView!

    //MARK: Declarando imagenes para establecer logos
    @IBOutlet weak var ccLogo: UIImageView!
    @IBOutlet weak var ccLogo2: UIImageView!
    
    //MARK: Declarando componentes para el form walktrought
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    
    //MARK: Declarando textFields para la información personal
    @IBOutlet weak var nameClienTxt: UITextField!
    @IBOutlet weak var lastNameClientTxt: UITextField!
    @IBOutlet weak var genreClientTxt: UITextField!
    @IBOutlet weak var rangoEdadClientTxt: UITextField!
    
    //MARK: Textfields para la sección de dirección
    @IBOutlet weak var suburbClientTxt: UITextField!
    @IBOutlet weak var zipCodeClientTxt: UITextField!
    @IBOutlet weak var townClientTxt: UITextField!
    @IBOutlet weak var cityClientTxt: UITextField!
    
    //MARK: Textfields para contacto
    @IBOutlet weak var mailClientTxt: UITextField!
    @IBOutlet weak var telClientTxt: UITextField!
    @IBOutlet weak var ccEventoTXT: UITextField!
    
    //MARK: Colección de botones
    @IBOutlet weak var continuaDataBtn: UIButton!
    @IBOutlet weak var finishContactBtn: UIButton!
    
    //MARK: Estableciendo variables para la selección de intereses
    var interes1: String = ""
    var interes2: String = ""
    var interes3: String = ""
    var interes4: String = ""
    var interes5: String = ""
    var interes6: String = ""
    var interes7: String = ""
    var interes8: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        downloadingEventData()
        
        let spinningActivity = MBProgressHUD.showAdded(to: tabBarController?.view, animated: true)
        spinningActivity?.labelText = "Configurando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        let defaultLogo = UserDefaults.standard.string(forKey: "logoUrlCC")
        
        let ccLogoURL = URL(string: "http://gsm.mallconcierge.mx/\(defaultLogo!)")

         DispatchQueue.global().async {
             
             let elLogoCC = NSData(contentsOf: ccLogoURL! as URL)
            
        
                 DispatchQueue.main.async(execute:{
                    
                     self.ccLogo.image = UIImage(data: elLogoCC! as Data)
                     self.ccLogo2.image = UIImage(data: elLogoCC! as Data)
                    
                     self.colorCCSlide1.backgroundColor = UIColor.universalColorForm
                     self.colorCCSlide2.backgroundColor = UIColor.universalColorForm
                    
                    spinningActivity?.hide(true)
                    
                 })
             
         }
         
        self.hideKeyboardWhenTappedAround()
        
        genreClientTxt.delegate = self
        rangoEdadClientTxt.delegate = self
        ccEventoTXT.delegate = self
        
        generoPicker.delegate = self
        generoPicker.dataSource = self
        
        rangoEdadPicker.delegate = self
        rangoEdadPicker.dataSource = self
        
        eventoPicker.delegate = self
        eventoPicker.dataSource = self
        
        genreClientTxt.inputView = generoPicker
        rangoEdadClientTxt.inputView = rangoEdadPicker
        ccEventoTXT.inputView = eventoPicker
        
        contentView_width.constant = self.view.frame.width * 2
        personalData.constant = self.view.frame.width
        contactData.constant = self.view.frame.width
        
        textRoundedTextFields(for: nameClienTxt)
        textRoundedTextFields(for: lastNameClientTxt)
        textRoundedTextFields(for: genreClientTxt)
        textRoundedTextFields(for: rangoEdadClientTxt)

        textRoundedTextFields(for: suburbClientTxt)
        textRoundedTextFields(for: zipCodeClientTxt)
        textRoundedTextFields(for: townClientTxt)
        textRoundedTextFields(for: cityClientTxt)
        
        textRoundedTextFields(for: mailClientTxt)
        textRoundedTextFields(for: telClientTxt)
        textRoundedTextFields(for: ccEventoTXT)
        
        padding(for: nameClienTxt)
        padding(for: lastNameClientTxt)
        padding(for: genreClientTxt)
        padding(for: rangoEdadClientTxt)
        padding(for: suburbClientTxt)
        padding(for: zipCodeClientTxt)
        padding(for: townClientTxt)
        padding(for: cityClientTxt)
        padding(for: mailClientTxt)
        padding(for: telClientTxt)
        padding(for: ccEventoTXT)
        
        botonesRedondos(for: continuaDataBtn)
        botonesRedondos(for: finishContactBtn)
        
        configure_footerView()

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.

    }
    
    //MARK: Función que cumple con el ciclo de vida de la aplicación
    override func viewDidAppear(_ animated: Bool) {
   
    super.viewDidAppear(animated)
        
    }
    
    //MARK: Función para procesar la pulsación del botón Volver para los textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Detecta activida de deslizamiento
    @objc func handle(_ gesture: UISwipeGestureRecognizer){
        
        let current_x = scrollView.contentOffset.x
        let screen_width = self.view.frame.width
        let new_x = CGPoint(x: current_x - screen_width, y:0)
        
        if current_x > 0{
            
            scrollView.setContentOffset(new_x, animated: true)
        
        }
    }
    //MARK: Control para ejecutar la función de cerrar sesión
    @IBAction func btnSalir(_ sender: Any){
        
        userLogout()
        
    }
    
    //MARK: Control que ejecuta la función para descargar los eventos
    @IBAction func downloadingEventDatar(_ sender: Any){

        downloadingEventData()
        
    }
    
    //MARK: Control que ejecuta la actividad de canclar el registro y poner los textfields en blanco
    @IBAction func cancelaClicked(_ sender: Any){
        
        nameClienTxt.text = ""
        lastNameClientTxt.text = ""
        genreClientTxt.text = ""
        rangoEdadClientTxt.text = ""
        suburbClientTxt.text = ""
        zipCodeClientTxt.text = ""
        townClientTxt.text = ""
        cityClientTxt.text = ""
        mailClientTxt.text = ""
        telClientTxt.text = ""
        ccEventoTXT.text = ""
        UserDefaults.standard.removeObject(forKey: "acepta")
        let position = CGPoint(x:0, y:0)
        scrollView.setContentOffset(position, animated: true)
        
    }
    
    //MARK: Control para dirigirse a la siguiente página
    @IBAction func formPage1_clicked(_ sender: Any){
        
        if nameClienTxt.text!.isEmpty == false && lastNameClientTxt.text!.isEmpty == false {
            
            let acepta = UserDefaults.standard.integer(forKey: "acepta")
            if acepta == 1{
                
                nameClienTxt.resignFirstResponder()
                let position = CGPoint(x:self.view.frame.width, y:0)
                scrollView.setContentOffset(position, animated: true)
                
            }else{
                
                let myAlert = UIAlertController(title: "Atención", message: "Antes de continuar, por favor revise y acepte el acuerdo de privacidad", preferredStyle: UIAlertController.Style.alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alertAction) in
                    
                    self.helper.instantiateViewController(identifier: "acuerdo", animated: true, by: self, completion: nil)
                    
                })
                
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion:nil)
                
            }
            
        }else{
            
            nameClienTxt.becomeFirstResponder()
                      
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            
        }
        
    }
    
    //MARK: Control para visualizar los intereses seleccionados
    @IBAction func verIntereses(_ sender: Any){
        cantIntrst = arrayInterest.count
    }
    
    //TODO: unwindSegue
    @IBAction func unwindToOne(_ sender: UIStoryboardSegue){
        
    }
    
    //MARK: Control que ejecuta el proceso de finalizar el registro y guardarlo de manera local
    @IBAction func formFinish_clicked(_ sender: Any){

        if mailClientTxt.text!.isEmpty == false && zipCodeClientTxt.text!.isEmpty == false {
        
            cantidadIntereses = arrayInterest.count
            if arrayInterest.isEmpty == false{
                
                print("Hay \(arrayInterest.count) intereses seleccionados en el arreglo: ")
                
                //MARK: Mecanismo de conrol para la selección de intereses
                switch cantidadIntereses {
       
                case 1:
                    
                    interes1 = arrayInterest[0]
                    //Imprimir variables guardadas
                    print("Interés 1: \(interes1)")
                    
                case 2:

                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    
                    
                case 3:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]

                  
                     
                case 4:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]
                    interes4 = arrayInterest[3]
                  
                    
                    
                case 5:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]
                    interes4 = arrayInterest[3]
                    interes5 = arrayInterest[4]
                   
                   
                    
                case 6:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]
                    interes4 = arrayInterest[3]
                    interes5 = arrayInterest[4]
                    interes6 = arrayInterest[5]

                 

                case 7:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]
                    interes4 = arrayInterest[3]
                    interes5 = arrayInterest[4]
                    interes6 = arrayInterest[5]
                    interes7 = arrayInterest[6]

                   
               
                case 8:
                    
                    interes1 = arrayInterest[0]
                    interes2 = arrayInterest[1]
                    interes3 = arrayInterest[2]
                    interes4 = arrayInterest[3]
                    interes5 = arrayInterest[4]
                    interes6 = arrayInterest[5]
                    interes7 = arrayInterest[6]
                    interes8 = arrayInterest[7]
        
                   
                default:
                    interes1 = arrayInterest[0]
                }
                
                savingUserDataLocally()
                
            }else{
               
                helper.showAlert(title: "Atención", message: "No hay intereses seleccionados", in: self)
                
            }
            print(arrayInterest)
            
        }else{
            
            mailClientTxt.becomeFirstResponder()
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un asterisco son obligatorios", in: self)
            
        }
        
    }
    
    //MARK: Función para cuando el usuario toca espacios en blanco
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
        self.view.endEditing(false)
        nameClienTxt.resignFirstResponder()
        telClientTxt.resignFirstResponder()
           
       }
    
    //MARK: Configura las esquinas de una vista
    func textRoundedTextFields(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    //MARK: Configura redondeando las esquinas de los botones
    func botonesRedondos(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    //MARK: Agrega rellenos a los textfields
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x:0, y:0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }
    
    
    //MARK: Control que detecta si el usuario pasa de escribir un textfields a otro
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        if textField == nameClienTxt || textField == lastNameClientTxt{
            
            if helper.isValid(nombre: nameClienTxt.text!) || helper.isValid(nombre: lastNameClientTxt.text!){
                
            }
            
        }
        
        if textField == mailClientTxt{
            
            if helper.isValid(email: mailClientTxt.text!){
                
                print("Correo valido")
                
            }
            
        }
        
        
    }
   
    // MARK: Descarga los eventos
    func downloadingEventData(){
        
        let url = URL(string: "http://api.mallconcierge.mx/API-movil/events.php")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do{
                    self.eventos = try JSONDecoder().decode([Eventos].self, from: data!)
                }catch{
                    print("Error de parsing")
                }
                DispatchQueue.main.async {
                    self.eventoPicker.reloadComponent(0)
                }
                print(self.eventos.count)
            }
        }.resume()
        
    }
    
    //MARK: Función para guardar los datos de manera local
    func savingUserDataLocally(){
        
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Registrando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        TableRecords.shared.insertar(id: idRecordCC, nombre: nameClienTxt.text!, apellido: lastNameClientTxt.text!, genero: genreClientTxt.text!, edad: rangoEdadClientTxt.text!,  colonia: suburbClientTxt.text!, zip: zipCodeClientTxt.text!, municipio: townClientTxt.text!, ciudad: cityClientTxt.text!, mail: mailClientTxt.text!, cel: telClientTxt.text!, evento: ccEventoTXT.text!, interes1: interes1, interes2: interes2, interes3: interes3, interes4: interes4, interes5: interes5, interes6: interes6, interes7: interes7, interes8: interes8, cantIntrsts: String(cantidadIntereses))
         
        spinningActivity?.hide(true)
        let myAlert = UIAlertController(title: "Gracias", message: "Registro Exitoso", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alertAction) in
            
            let position = CGPoint(x:0, y:0)
            self.scrollView.setContentOffset(position, animated: true)

            self.nameClienTxt.text = ""
            self.lastNameClientTxt.text = ""
            self.genreClientTxt.text = ""
            self.rangoEdadClientTxt.text = ""
            self.suburbClientTxt.text = ""
            self.zipCodeClientTxt.text = ""
            self.townClientTxt.text = ""
            self.cityClientTxt.text = ""
            self.mailClientTxt.text = ""
            self.ccEventoTXT.text = ""
            self.telClientTxt.text = ""
            
        })
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil)
        
        UserDefaults.standard.removeObject(forKey: "acepta")
        
    }
    
    //MARK: Función para el cierre de sesión del usuario
    func userLogout(){
        
        UserDefaults.standard.removeObject(forKey: "CCid")
        UserDefaults.standard.removeObject(forKey: "logoUrlCC")
        UserDefaults.standard.removeObject(forKey: "CCColorForm")
        UserDefaults.standard.removeObject(forKey: "acepta")
        self.dismiss(animated: true, completion: nil)
        
    }
   
    //MARK: Configura el footer de la vista
    func configure_footerView(){
        
        let topLine = CALayer()
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        footView.layer.addSublayer(topLine)
        
    }
    
    //MARK: Establece el número de componentes para el picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Establece el número de elementos en un picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if currentTextField == genreClientTxt{
            
            return dataSource.count
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge.count
            
        }else if currentTextField == ccEventoTXT{
            
            return eventos.count
            
        }else{
            
            return 0
            
        }
        
    }
    
    //MARK: Cuando se selecciona un elemento en el picker el dato se muestra en el textfields
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if currentTextField == genreClientTxt{
            
            if row == 0{
             
                generoPicker.selectRow(row+1, inComponent: component, animated: true)
                genreClientTxt.text = dataSource[row+1]
                
              }else{
                  
                genreClientTxt.text = dataSource[row]
                  
              }
            
            
        }else if currentTextField == rangoEdadClientTxt{
            
            if row == 0{
                
                rangoEdadPicker.selectRow(row+1, inComponent: component, animated: true)
                rangoEdadClientTxt.text = dataSourceAge[row+1]
                
            }else{
                
                rangoEdadClientTxt.text = dataSourceAge[row]
                
            }
            
        }else if currentTextField == ccEventoTXT{
            
            ccEventoTXT.text = eventos[row].ccEventName
            
        }
        
    }

    //MARK: Establece el título de las celdas para el componente
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTextField == genreClientTxt{
            
            return dataSource[row]
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge[row]
            
        }else if currentTextField == ccEventoTXT{
            
            return eventos[row].ccEventName
            
        }
        
        return ""
        
    }
    
    //MARK: Cuando en el textfield se le ingresa dato se ejecuta el picker
    func textFieldDidBeginEditing(_ textField: UITextField) {

        currentTextField = textField
        
        if currentTextField == genreClientTxt{
            
            currentTextField.inputView = generoPicker
            
        }else if currentTextField == rangoEdadClientTxt{
            
            currentTextField.inputView = rangoEdadPicker
            
        }else if currentTextField == ccEventoTXT{
            
            currentTextField.inputView = eventoPicker
            
        }
       
    }

}

//MARK: Convierte los colores hexadecimales 
extension UIColor{
    
    static let defaultColorForm: String = UserDefaults.standard.string(forKey:"ccColorForm")!
    
    static let universalColorForm = UIColor().colorFromHex( defaultColorForm)

    
    func colorFromHex (_ hex: String) -> UIColor{
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6{
            return UIColor.black
        }
        
        var rgb : UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                          green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                          blue: CGFloat(rgb & 0x0000FF) / 255.0,
                          alpha: 1.0)
    }
}
