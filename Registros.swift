//
//  Registros.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import Foundation

class Registros{
    
    var id : Int64
    var nombre : String
    var apellido : String
    var genero : String
    var edad : String

    
    var colonia : String
    
    var zip : String
    var municipio : String
    var ciudad : String
    var mail : String
    var cel : String
    var event : String
    
    var interes1 : String
    var interes2 : String
    var interes3 : String
    var interes4 : String
    var interes5 : String
    var interes6 : String
    var interes7 : String
    var interes8 : String
    
    var cantInterest : String
    
    
    init(id: Int64, nombre: String, apellido: String, genero: String, edad: String, colonia: String, zip: String, municipio: String, ciudad: String, mail: String, cel: String, event: String, interes1: String, interes2: String, interes3: String, interes4: String, interes5: String, interes6: String, interes7: String, interes8: String, cantInterest: String) {
        
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.genero = genero
        self.edad = edad
        self.colonia = colonia
        self.zip = zip
        self.municipio = municipio
        self.ciudad = ciudad
        self.mail = mail
        self.cel = cel
        self.event = event
        
        self.interes1 = interes1
        self.interes2 = interes2
        self.interes3 = interes3
        self.interes4 = interes4
        self.interes5 = interes5
        self.interes6 = interes6
        self.interes7 = interes7
        self.interes8 = interes8
        self.cantInterest = cantInterest
        
        
    }
    
}
