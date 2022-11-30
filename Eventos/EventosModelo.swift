//
//  EventosModelo.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 18/03/21.
//

import UIKit
protocol EventosModeloProtocol: class {
    func downloadedEventos (items: NSArray)
}

class EventosModelo: NSObject {
    
    weak var delegate: EventosModeloProtocol!
    
    let urlPath = "http://gsm.mallconcierge.mx/API-movil/events.php"
    
    func eventosDescargados(){
        
        let url: URL = URL (string: urlPath)!
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
        let detalles = NSMutableArray()
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
            let detalle = DetallesEvento()
            
            let idEvento = jsonElement["ccEventID"]
            let eventoNombre = jsonElement["ccEventName"]
            
            
            
        }
    }

}
