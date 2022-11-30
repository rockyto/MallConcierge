//
//  InteresesModelo.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 22/07/21.
//

import UIKit

protocol InteresesModeloProtocol: AnyObject{
    func interesesDownload (interest: [DetallesIntereses])
}

class InteresesModelo: NSObject {
    
    weak var delegate: InteresesModeloProtocol!
    
    let urlPath = "http://api.mallconcierge.mx/API-movil/interests.php"
    
    func interestDownload(){
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.ephemeral)
        URLCache.shared.removeAllCachedResponses()
        let task = defaultSession.dataTask(with: url){
            (data, response, error) in
            if error != nil{
                
                print("Error al descargar datos")
                
            }else{
                
                print("Datos descargados")
                self.parseJSON(data!)
                
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ data:Data){
        
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        
        var detalles = [DetallesIntereses]()
        
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
            let detalle = DetallesIntereses()
            
            let idInteres: String = jsonElement["idInteres"] as! String
            let nombreInteres: String = jsonElement["interesNombre"] as! String
            
            detalle.idInteres = idInteres
            detalle.nombreInteres = nombreInteres
            
            detalles.append(detalle)
            
        }
        
        DispatchQueue.main.async(execute: { ()-> Void in
            
            self.delegate.interesesDownload(interest: detalles)
        })
            
        
    }

}
