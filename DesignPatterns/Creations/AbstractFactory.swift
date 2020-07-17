//
//  AbstractFactory.swift
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
protocol Checkbox {
    func paint()
}
protocol GUI {
    func createButton() -> Button
    func createCheckbox() -> Checkbox
}
enum OSType {
    case mac
    case win
}

// B2:
class WindowButton {
}
extension WindowButton: Button {
    func render() {
        print("render Window button")
    }
}

class WindowCheckbox {
}
extension WindowCheckbox: Checkbox {
    func paint() {
        print("render Window Checkbox")
    }
}

class MacButton {
}
extension MacButton: Button {
    func render() {
        print("render Mac button")
    }
}

class MacCheckbox {
}
extension MacCheckbox: Checkbox {
    func paint() {
        print("render Mac Checkbox")
    }
}

// B3: Class to use
class WinFactory: GUI {
    func createButton() -> Button {
        return WindowButton()
    }
    
    func createCheckbox() -> Checkbox {
        return WindowCheckbox()
    }
}
class MacFactory: GUI {
    func createButton() -> Button {
        return MacButton()
    }
    
    func createCheckbox() -> Checkbox {
        return MacCheckbox()
    }
}

// B4:
class GUIFactory {
    private init() {
    }
    
    static func gui(os: OSType) -> GUI {
        switch os {
        case .mac:
            return MacFactory()
        case .win:
            return WinFactory()
        }
    }
}

// Final class
class AbstractFactory {
    func main() -> Int {
        let macGui = GUIFactory.gui(os: .mac)
        
        let button = macGui.createButton()
        button.render()
        print("\n")
        let chb = macGui.createCheckbox()
        chb.paint()
        
        return 1
    }
}
*/
