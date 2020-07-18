//
//  Factory.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

// B1:
protocol Button {
    func render()
}
enum OSType {
    case mac
    case win
}

// B2:
class Mac {
}
extension Mac: Button {
    func render() {
        print("Render Mac")
    }
}

class Window {
}
extension Window: Button {
    func render() {
        print("Render Window")
    }
}

// Class to use
class ButtonFactory {
    private init() {
    }
    
    static func button(os: OSType) -> Button {
        switch os {
        case .mac:
            return Mac()
        case .win:
            return Window()
        }
    }
}

// Final class
class Factory {
    func main() -> Int {
        let macBtn = ButtonFactory.button(os: .mac)
        let winBtn = ButtonFactory.button(os: .win)
        
        macBtn.render()
        print("\n")
        winBtn.render()
        
        return 0
    }
}
*/
