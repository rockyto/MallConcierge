//
//  Helper.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import UIKit

class Helper: NSObject {
    
    func isValid(email: String) -> Bool{
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: email)
        return result
        
    }
    
    func isValid(nombre: String) -> Bool{
        
        let regex = "[A-Za-z ]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: nombre)
        return result
        
    }
    
    func showAlert(title: String, message: String, in vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    func instantiateViewController(identifier: String, animated: Bool, by vc: UIViewController, completion: (() -> Void)?){
        
        let nuevoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        
        nuevoViewController.modalPresentationStyle = .custom
        vc.present(nuevoViewController, animated: animated, completion: completion)
    }
    
    
    
     
    
    
    
    
}
protocol isAbleToReceiveData {
  func pass(data: String)  //data: string is an example parameter
}
