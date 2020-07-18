//
//  Adapter.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// B3: Action in vietnamese target
protocol Sender {
    func send(words: String)
}

protocol Receiver {
    func receive(words: String)
}

// B1: Send message
class VietNameseClient {
    private let receiver: Receiver
    init(receiver: Receiver) {
        self.receiver = receiver
    }
}
extension VietNameseClient: Sender {
    func send(words: String) {
        receiver.receive(words: words)
    }
}

// B2: Receive message
class JapanseClient {
}
extension JapanseClient: Receiver {
    func receive(words: String) {
        // PROBLEM: What??? I don't know english
        print("Retrieving words from client ... \n \(words)")
    }
}

// Final class
class Adapter {
    func main() -> Int {
        
        // PROBLEM: I want to send vietnamese message to Japanese client
        // But I don't know japanese language
        // Solve: I need a translator who knows japanese language
        let jpanClient = JapanseClient()
        let vnClient = VietNameseClient(receiver: jpanClient)
        vnClient.send(words: "Hello")
        
        return 1
    }
}
