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
    // SOLVE B3: use translator instead of implementing
    private let translator: Sender
    init(translator: Sender) {
        self.translator = translator
    }
}
extension VietNameseClient: Sender {
    func send(words: String) {
        // SOLVE B4: use translator instead of directly using receiver
        print("Nguoi viet nam noi... \(words)")
        return translator.send(words: words)
    }
}

// SOLVE B1: Make translator (Adapter class)
class JPTranslator {
    private let receiver: Receiver
    
    init(receiver: Receiver) {
        self.receiver = receiver
    }
    
    private func translate(words: String) -> String {
        return "こんにちは"
    }
}
extension JPTranslator: Sender {
    func send(words: String) {
        let newWords = translate(words: words)
        
        print("I would like to translate from \(words) to \(newWords)")
        
        // SOLVE B2: Adapter with new value
        return receiver.receive(words: newWords)
    }
}


// B2: Receive message
class JapanseClient {
}
extension JapanseClient: Receiver {
    func receive(words: String) {
        print("Japanse Client was recieved ... \(words)")
    }
}

// Final class
class Adapter {
    func main() -> Int {
        // PROBLEM: I want to send vietnamese message to Japanese client
        // But I don't know japanese language
        // Solve: I need a translator who knows japanese language
        let jpanClient = JapanseClient()
        let translator = JPTranslator(receiver: jpanClient)
        let vnClient = VietNameseClient(translator: translator)
        
        vnClient.send(words: "Xin Chao")
        return 1
    }
}
