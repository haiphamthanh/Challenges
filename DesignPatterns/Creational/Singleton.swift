//
//  Singleton.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

class Singleton {
    // B1: make onetime creating instance
    static let shared = Singleton()
    
    // B2: private init function
    private init() {
    }
    
    // B3: Sample function and variable to call
    var value = "sample value"
    func sampleFunction() -> String {
        return "\(#function)"
    }
}
