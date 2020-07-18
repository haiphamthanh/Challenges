//
//  ObjectPool.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/17/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

class Taxi {
//    // B2: Make some robot infors
//    private var seri: String
//    private var name: String
//    init(seri: String? = nil, name: String = "Alexa") {
//        self.seri = seri ?? "\(Int.random(in: 0..<9999))"
//        self.name = name
//    }
//
//    // B1: CLONE function
//    func clone() -> Robot {
//        // B3: Return allthings about this robot information
//        return Robot(seri: seri, name: name)
//    }
//
//    // B4: Make testing function
//    func intro() -> String {
//        return "My name is \(name)"
//    }
}

class TaxiPool {
    private let maxCar = 10 // Number of object in pool
    private let expireTimeInMili = 1200 // Wait for create new object
    private var inUse = [Taxi]()
    private var available = [Taxi]()
    
    func freeTaxi() -> Taxi? {
        return taxiFacade()
    }
    
    private func taxiFacade() -> Taxi? {
        var taxi = pop()
        
        if nil == taxi {
            // Return new car if current number of car have not enough
            let numberCar = available.count + inUse.count
            if numberCar < maxCar {
                taxi = newCar()
            } else {
                // Return after waiting
            }
        }
        
        if let taxi = taxi {
            inUse.append(taxi)
        }
        
        return taxi
    }
    
    private func pop() -> Taxi? {
    }
    
    private func push(taxi: Taxi) {
        
    }
    
    private func newCar() -> Taxi {
        return Taxi()
    }
}

// Final class
class ObjecPool {
    func main() -> Int {
        //
        // PROBLEM: I want to have a taxi
        // Solution1: Everytime I have a call I buy a new car
        let newTaxi = Taxi()
        
        // Solution2: Manage and reuse car which is freezing
        let newTaxiS2 = TaxiPool.taxi()
        
        
        return 1
    }
}
*/
