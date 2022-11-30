//
//  TableRecords.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import Foundation
import SQLite

class TableRecords {
    
    static let shared = TableRecords()
    
    private let table = Table("recordsClientsCC")
    
    private let id = Expression<Int64>("idCCRecordsClients")
    private let nombre = Expression<String>("clientName")
    private let apellido = Expression<String>("clientLastName")
    
    private let genero = Expression<String>("clientGenre")
    private let edad = Expression<String>("clientAge")
    
    private let colonia = Expression<String>("clientSuburb")
    
    private let zip = Expression<String>("clientZipCode")
    private let municipio = Expression<String>("clientTown")
    private let ciudad = Expression<String>("clientCity")
    private let mail = Expression<String>("clientMail")
    private let cel = Expression<String>("clientCell")
    private let evento = Expression<String>("ccEvento")
    
    private let interes1 = Expression<String>("ccInteres1")
    private let interes2 = Expression<String>("ccInteres2")
    private let interes3 = Expression<String>("ccInteres3")
    private let interes4 = Expression<String>("ccInteres4")
    private let interes5 = Expression<String>("ccInteres5")
    private let interes6 = Expression<String>("ccInteres6")
    private let interes7 = Expression<String>("ccInteres7")
    private let interes8 = Expression<String>("ccInteres8")
    
    private let cantIntrsts = Expression<String>("cantIntrsts")
    
    private init(){
        do{
            if let conexion = Database.shared.conexion{
                try conexion.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
                    
                    t.column(self.id, primaryKey: true)
                    t.column(self.nombre)
                    t.column(self.apellido)
                    t.column(self.genero)
                    t.column(self.edad)
                    t.column(self.colonia)
                    t.column(self.zip)
                    t.column(self.municipio)
                    t.column(self.ciudad)
                    t.column(self.mail)
                    t.column(self.cel)
                    t.column(self.evento)
                    
                    t.column(self.interes1)
                    t.column(self.interes2)
                    t.column(self.interes3)
                    t.column(self.interes4)
                    t.column(self.interes5)
                    t.column(self.interes6)
                    t.column(self.interes7)
                    t.column(self.interes8)
                    
                    t.column(self.cantIntrsts)
                    
                }))
                
                print("La tabla se creo correctamente")
                
            }else{
                print("La tabla no se creó")
            }
        } catch let error as NSError {
            
            print("La tabla no se creo", error)
            
        }
    }
    
    func insertar(id: Int, nombre: String, apellido: String, genero: String, edad: String, colonia: String, zip: String, municipio: String, ciudad: String, mail: String, cel: String, evento: String, interes1: String, interes2: String, interes3: String, interes4: String, interes5: String, interes6: String, interes7: String, interes8: String, cantIntrsts: String){

        do{
            let insertar = table.insert(self.nombre <- nombre, self.apellido <- apellido, self.genero <- genero, self.edad <- edad, self.colonia <- colonia, self.zip <- zip, self.municipio <- municipio, self.ciudad <- ciudad, self.mail <- mail, self.cel <- cel, self.evento <- evento, self.interes1 <- interes1, self.interes2 <- interes2, self.interes3 <- interes3, self.interes4 <- interes4, self.interes5 <- interes5, self.interes6 <- interes6, self.interes7 <- interes7, self.interes8 <- interes8, self.cantIntrsts <- cantIntrsts)
            
            try Database.shared.conexion?.run(insertar)
        } catch let error as NSError{
            print("error al guardar", error)
        }
    }
    
    func borrar(ids: Int64){
        
        let identificador = table.filter(id == ids)
        try! Database.shared.conexion?.run(identificador.delete())
        print("Registro borrado correctamente")
        
    }
    
}
