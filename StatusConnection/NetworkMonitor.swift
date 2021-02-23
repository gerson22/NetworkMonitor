//
//  NetworkMonitor.swift
//  StatusConnection
//
//  Created by Gerson Isaias on 16/02/21.
//

import UIKit
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    let queue = DispatchQueue.global()
    let monitor: NWPathMonitor
    
    public private(set) var isConnected:Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status != .unsatisfied
            self.getConnectionType(path)
        }
    }
    
    func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
    }
}
