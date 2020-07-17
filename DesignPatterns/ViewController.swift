//
//  ViewController.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/16/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var taxiLable: UILabel!
    private var inUse = [Int]()
    private var available = [1, 2, 3, 4, 5]
    private var timer = Timer()
    private var callCarTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scheduledTimerWithTimeInterval()
    }
    
    @IBAction func callTaxi(_ sender: UIButton) {
        callCar()
        callCarTimer.invalidate()
        callCarTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callCar), userInfo: nil, repeats: true)
    }
    
    @objc func callCar() {
        let num = availableCar()
        let isGotCar = (num != nil)
        if isGotCar {
            pushNumber(num: num!)
            callCarTimer.invalidate()
        }
        
        return taxiLable.text = (num != nil) ? "Car number is \(num!)" : "Car is not available"
    }

    func availableCar() -> Int? {
        let num = available.last
        if num != nil {
            available.removeLast()
        }
        
        return num
    }
    
    func pushNumber(num: Int) {
        inUse.append(num)
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        return useCar()
    }
    
    func useCar() {
        let num = availableCar()
        if num != nil {
            pushNumber(num: num!)
            
            print("Car \(num!) in used")
            print("inUse \(inUse)")
            print("available \(available)")
            print("\n--------\n")
            
            return
        }
        print("Car is not available")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
            // Reset data
            print("Reset cars")
            self?.available = [1, 2, 3, 4, 5]
            self?.inUse.removeAll()
        }
    }
}
