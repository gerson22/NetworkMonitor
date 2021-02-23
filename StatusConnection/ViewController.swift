//
//  ViewController.swift
//  StatusConnection
//
//  Created by Gerson Isaias on 16/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionTxt: UILabel!
    
    var _connectionType:String!
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        if self.isOnline() {
            // Ejecutar algun consumo de servicio
        }else{
            //mostrar un mensaje uo alerta de que no hay conexion a internet
        }
        
    }
    
    func isOnline()-> Bool{
        if NetworkMonitor.shared.isConnected {
            switch NetworkMonitor.shared.connectionType {
            case .wifi:
                _connectionType = "WI-Fi"
                break
            case .cellular:
                _connectionType = "Datos moviles"
                break
            case .ethernet:
                _connectionType = "Ethernet"
                break
            default:
                _connectionType = "No hay conexion a internet"
                break
            }
            self.connectionTxt.text = "Connected:" + _connectionType
        }else {
            self.connectionTxt.text = "Disconnected: "
        }
        return NetworkMonitor.shared.isConnected
    }


}

