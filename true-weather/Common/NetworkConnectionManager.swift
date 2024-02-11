//
//  NetworkConnectionManager.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import Foundation
import Network

class NetworkConnectionManager: ObservableObject {
    
    private var monitor: NWPathMonitor
    @Published var isConnected: Bool = true
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
