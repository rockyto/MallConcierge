//
//  InteresesViewController.swift
//  MallConcierge
//
//  Created by Rodrigo Sánchez on 22/07/21.
//

import UIKit

class InteresesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,  InteresesModeloProtocol {
    
    var selectIntereses = [String]()
    
    var feedInterests = [DetallesIntereses]()
    
    var arregloIntereses = [""]
    
    var selectInterests: DetallesIntereses = DetallesIntereses()
    
    var items=[String]()
    
    @IBOutlet var listaInteresesTableView: UITableView!

    func interesesDownload(interest: [DetallesIntereses]) {
         feedInterests = interest
         self.listaInteresesTableView.reloadData()
     }
    
    
    override func viewDidLoad() {
        
        self.listaInteresesTableView.isEditing = true
        self.listaInteresesTableView.allowsMultipleSelectionDuringEditing = true

        self.listaInteresesTableView.delegate = self
        self.listaInteresesTableView.dataSource = self
        
        let interesesModelo = InteresesModelo()
        interesesModelo.delegate = self
        interesesModelo.interestDownload()
        
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedInterests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celInterests", for: indexPath) as! InteresesTableViewCell
        let interest: DetallesIntereses = feedInterests[indexPath.row]
        
        cell.lblNombreIntereses!.text = interest.nombreInteres
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectDeselectCell(tableView: listaInteresesTableView, indexPath: indexPath)
        print("Seleccionado")
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: listaInteresesTableView, indexPath: indexPath)
        print("Deseleccionado")
    }
    
    func selectDeselectCell(tableView: UITableView, indexPath: IndexPath) {
        self.selectIntereses.removeAll()
        
        if let arr = listaInteresesTableView.indexPathsForSelectedRows {
            for index in arr {
            
                if let interest = feedInterests[index.row] as? DetallesIntereses, let nameI =  interest.nombreInteres {
                        selectIntereses.append(nameI)
                }

            }
        }
        print(selectIntereses)
    }
    
    @IBAction func seleccionarIntereses(_ sender: Any){
        
        print(selectIntereses)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! FormMiniRegisterVC
        destVC.arrayInterest = selectIntereses
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController{
    
  
}
