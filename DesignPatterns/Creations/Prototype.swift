//
//  Prototype.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/17/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

class Robot {
    // B2: Make some robot infors
    private var seri: String
    private var name: String
    init(seri: String? = nil, name: String = "Alexa") {
        self.seri = seri ?? "\(Int.random(in: 0..<9999))"
        self.name = name
    }
    
    // B1: CLONE function
    func clone() -> Robot {
        // B3: Return allthings about this robot information
        return Robot(seri: seri, name: name)
    }
    
    // B4: Make testing function
    func intro() -> String {
        return "My name is \(name)"
    }
}

// Final class
class Prototype {
    func main() -> Int {
        let robot = Robot(name: "Columbus")
        
        // PROBLEM: How to copy available robot to various delivery
        let newRobot = robot.clone()
        
        // Test data
        print("\(robot.intro())")
        print("\n")
        print("\(newRobot.intro())")
        
        return 1
    }
}
*/
