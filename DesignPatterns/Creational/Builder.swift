//
//  Builder.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

// B1: Define types
enum ButtonType {
    case rectangle
    case ovan
}
enum SwitchType {
    case radio
    case combobox
}

// B2: Create class
class Machine {
    // B3: Create properties
    private var buttonType: ButtonType
    private var switchTyle: SwitchType
    
    // B4: Make BUILDER function with default values
    init(btnType: ButtonType = .rectangle, swType: SwitchType = .radio) {
        self.buttonType = btnType
        self.switchTyle = swType
    }
    
    // Others functions
    func description() -> String {
        return "\(buttonType) \(switchTyle)"
    }
}

// Final class
class Builder {
    func main() -> Int {
        let machine = Machine()
        let otherMachine = Machine(btnType: .ovan)
        
        print(machine.description())
        print("\n")
        print(otherMachine.description())
        
        return 1
    }
}
*/
