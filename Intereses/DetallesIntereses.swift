//
//  DetallesIntereses.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 22/07/21.
//

import UIKit

class DetallesIntereses: NSObject {
    
    var idInteres: String?
    var nombreInteres: String?
    
    override init() {
        
    }
    
    init(idInteres: String, nombreInteres:String) {
        
        self.idInteres = idInteres
        self.nombreInteres = nombreInteres
        
    }
    
    override var description: String{
        
        return "idInteres: \(idInteres), nombreInteres: \(nombreInteres)"
        
    }

}
