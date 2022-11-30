//
//  Database.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 20/11/20.
//

import Foundation
import SQLite

class Database{
    
    static let shared = Database()
    public let conexion : Connection?
    public let dataBaseName = "ccGSMRecords.sqlite3"
    
    private init(){
        
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as? String
        
        do{
            conexion = try Connection("\(dbPath!)/(dataBaseName)")
        }catch {
            
            conexion = nil
            let error = error as NSError
            print("fallo la conexión", error)
            
        }
        
    }
    
}
