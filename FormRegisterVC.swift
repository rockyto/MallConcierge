//
//  FormRegisterVC.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import SQLite
import UIKit


class FormRegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var idRecordCC: Int = 0
    let helper = Helper()

    var currentTextField = UITextField()
    
    let dataSource = ["-Genero-", "Hombre", "Mujer", "Prefiero no decirlo"]
    let dataSourceAge = ["-Rango de edad-","15-25", "26-35", "36-45", "46-55", "56-65", "65 o más"]
    let dataSourceEvent = ["-Elija un evento-", "Navidad","San Valentín", "Día de las Madres", "Día del Padres", "Día del niño", "Día del Abuelo", "Arte Abierto", "Octubre Rosa", "Rifa vehículo", "Tómbola", "Día de Muertos", "Fitness", "Mascotas", "Gastronomía", "Parque", "Bebidas"]
    
    var generoPicker = UIPickerView()
    var rangoEdadPicker = UIPickerView()
    var eventoPicker = UIPickerView()
    
    //MARK: Constraints
    @IBOutlet weak var personalData: NSLayoutConstraint!
    @IBOutlet weak var addressData: NSLayoutConstraint!
    @IBOutlet weak var contactData: NSLayoutConstraint!
    @IBOutlet weak var footView: UIView!
    
    @IBOutlet weak var colorCCSlide1: UIView!
    @IBOutlet weak var colorCCSlide2: UIView!
    @IBOutlet weak var colorCCSlide3: UIView!
    
    @IBOutlet weak var ccLogo: UIImageView!
    @IBOutlet weak var ccLogo2: UIImageView!
    @IBOutlet weak var ccLogo3: UIImageView!

    
    //MARK: Estableciendo componentes
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    
    //MARK: Estableciendo textFields para la información personal
    @IBOutlet weak var nameClienTxt: UITextField!
    @IBOutlet weak var lastNameClientTxt: UITextField!
    @IBOutlet weak var genreClientTxt: UITextField!

    @IBOutlet weak var rangoEdadClientTxt: UITextField!
    
    //Direccion
    @IBOutlet weak var suburbClientTxt: UITextField!
    @IBOutlet weak var zipCodeClientTxt: UITextField!
    @IBOutlet weak var townClientTxt: UITextField!
    @IBOutlet weak var cityClientTxt: UITextField!
    
    //Contacto
    @IBOutlet weak var mailClientTxt: UITextField!
    @IBOutlet weak var telClientTxt: UITextField!
    @IBOutlet weak var ccEventoTXT: UITextField!
    
    //Colección de botones
    @IBOutlet weak var continuaDataBtn: UIButton!
    @IBOutlet weak var continuaAddressBtn: UIButton!
    @IBOutlet weak var finishContactBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinningActivity = MBProgressHUD.showAdded(to: tabBarController?.view, animated: true)
        spinningActivity?.labelText = "Configurando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        let defaultLogo = UserDefaults.standard.string(forKey: "logoUrlCC")
        
        let ccLogoURL = NSURL(string: "https://gsm.programandoideas.com.mx/\(defaultLogo!)")

         DispatchQueue.global().async {
             
             let elLogoCC = NSData(contentsOf: ccLogoURL! as URL)
            
        
                 DispatchQueue.main.async(execute:{
                    
                     self.ccLogo.image = UIImage(data: elLogoCC! as Data)
                     self.ccLogo2.image = UIImage(data: elLogoCC! as Data)
                     self.ccLogo3.image = UIImage(data: elLogoCC! as Data)
                    
                     self.colorCCSlide1.backgroundColor = UIColor.universalColorForm
                     self.colorCCSlide2.backgroundColor = UIColor.universalColorForm
                     self.colorCCSlide3.backgroundColor = UIColor.universalColorForm
                    
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
        
        contentView_width.constant = self.view.frame.width * 3
        personalData.constant = self.view.frame.width
        addressData.constant = self.view.frame.width
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
        botonesRedondos(for: continuaAddressBtn)
        botonesRedondos(for: finishContactBtn)
        
        configure_footerView()

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("Ejecuta acción")
        return true
    }
    
    
    @objc func handle(_ gesture: UISwipeGestureRecognizer){
        
        let current_x = scrollView.contentOffset.x
        let screen_width = self.view.frame.width
        let new_x = CGPoint(x: current_x - screen_width, y:0)
        
        if current_x > 0{
            
            scrollView.setContentOffset(new_x, animated: true)
        
        }
    }
    
    @IBAction func btnSalir(_ sender: Any){
        
        salir()
        
    }
    
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
    
    @IBAction func continuaPDB_clicked(_ sender: Any){
            
        if nameClienTxt.text!.isEmpty == false && lastNameClientTxt.text!.isEmpty == false && genreClientTxt.text!.isEmpty == false{
            
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
    
    @IBAction func continuaDB_clicked(_ sender: Any){
        
        if zipCodeClientTxt.text!.isEmpty == false {
            
            zipCodeClientTxt.resignFirstResponder()
            
            let position = CGPoint(x:self.view.frame.width * 2, y:0)
            scrollView.setContentOffset(position, animated: true)
            
        }else{
            
            suburbClientTxt.becomeFirstResponder()
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            
        }
        
    }
    
    @IBAction func continuaCB_clicked(_ sender: Any){
        
        if mailClientTxt.text!.isEmpty == false && telClientTxt.text!.isEmpty == false {
        
            //guardaLocal()
            
            
        }else{
            
            mailClientTxt.becomeFirstResponder()
            
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            
        }
        
    }
    
    @IBAction func muestraDatosBtn(_ sender: Any){

        muestraDatos()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
        self.view.endEditing(false)
        nameClienTxt.resignFirstResponder()
        telClientTxt.resignFirstResponder()
           
       }
    
    func textRoundedTextFields(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    func botonesRedondos(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x:0, y:0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        if textField == nameClienTxt || textField == lastNameClientTxt{
            
            if helper.isValid(nombre: nameClienTxt.text!) || helper.isValid(nombre: lastNameClientTxt.text!){
                
                continuaDataBtn.isEnabled = true
                print("Nombre valido")
                
            }
            
        }
        
        if textField == mailClientTxt{
            
            if helper.isValid(email: mailClientTxt.text!){
                
                finishContactBtn.isEnabled = true
                
                print("Correo valido")
                
            }
            
        }
        
        
    }
    
    /*
    func guardaLocal(){
        
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Registrando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        TableRecords.shared.insertar(id: idRecordCC, nombre: nameClienTxt.text!, apellido: lastNameClientTxt.text!, genero: genreClientTxt.text!, edad: rangoEdadClientTxt.text!,  colonia: suburbClientTxt.text!, zip: zipCodeClientTxt.text!, municipio: townClientTxt.text!, ciudad: cityClientTxt.text!, mail: mailClientTxt.text!, cel: telClientTxt.text!, evento: ccEventoTXT.text!)
         
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
    */
    
    func muestraDatos(){
        
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {

             print("id: \(row[0]!), nombre: \(row[1]!), apellido: \(row[2]!), genero: \(row[3]!), edad: \(row[4]!), colonia: \(row[5]!), zip: \(row[6]!), municipio: \(row[7]!), ciudad: \(row[8]!), mail: \(row[9]!), cel: \(row[10]!)")

         }
        
    }
    
    func salir(){
        
        UserDefaults.standard.removeObject(forKey: "CCid")
        UserDefaults.standard.removeObject(forKey: "logoUrlCC")
        UserDefaults.standard.removeObject(forKey: "CCColorForm")
        UserDefaults.standard.removeObject(forKey: "acepta")

        self.dismiss(animated: true, completion: nil)
        
    }
   
    
    func configure_footerView(){
        
        let topLine = CALayer()
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        footView.layer.addSublayer(topLine)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if currentTextField == genreClientTxt{
            
            return dataSource.count
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge.count
            
        }else if currentTextField == ccEventoTXT{
            
            return dataSourceEvent.count
            
        }else{
            
            return 0
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if currentTextField == genreClientTxt{
            
            if row == 0{
                
                generoPicker.selectRow(row+1, inComponent: component, animated: true)
                  
              }else{
                  
                genreClientTxt.text = dataSource[row]
                self.view.endEditing(true)
                  
              }
            
        }else if currentTextField == rangoEdadClientTxt{
            
            if row == 0{
                
                rangoEdadPicker.selectRow(row+1, inComponent: component, animated: true)
                
            }else{
                
                rangoEdadClientTxt.text = dataSourceAge[row]
                self.view.endEditing(true)
                
            }
            
        }else if currentTextField == ccEventoTXT{
            
            if row == 0{
                
                eventoPicker.selectRow(row+1, inComponent: component, animated: true)
                
            }else{
                
                ccEventoTXT.text = dataSourceEvent[row]
                self.view.endEditing(true)
                
            }
        }
        
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTextField == genreClientTxt{
            
            return dataSource[row]
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge[row]
            
        }else if currentTextField == ccEventoTXT{
            
            return dataSourceEvent[row]
            
        }
        
        return ""
        
    }
    
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

//extension UIColor{
//    
//    static let defaultColorForm: String = UserDefaults.standard.string(forKey:"ccColorForm")!
//    
//    static let universalColorForm = UIColor().colorFromHex( defaultColorForm)
//
//    
//    func colorFromHex (_ hex: String) -> UIColor{
//        
//        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        
//        if hexString.hasPrefix("#"){
//            hexString.remove(at: hexString.startIndex)
//        }
//        
//        if hexString.count != 6{
//            return UIColor.black
//        }
//        
//        var rgb : UInt32 = 0
//        Scanner(string: hexString).scanHexInt32(&rgb)
//        
//        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
//                          green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
//                          blue: CGFloat(rgb & 0x0000FF) / 255.0,
//                          alpha: 1.0)
//    }
//}
