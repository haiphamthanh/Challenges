//
//  ThreadingProblem.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

class ThreadingProblem {
    private var currentMoney: Int = 1200
    let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
    
    let q1 = DispatchQueue(label: "1")
    let q2 = DispatchQueue(label: "2")
    
    private var object1 = "Object 1"
    private var object2 = "Object 2"
    
    let queue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)
    
    var a = [17]
    
    let deadlockQueue = DispatchQueue(label: "DeadlockQueue")
    
    func raceCondition() {
        queue.async { [weak self] in
            //            let firstATM = ATM(tag: "firstATM")
            //            firstATM.withdraw(value: 1000)
            self?.withdraw(money: 1000)
        }
        
        queue.async { [weak self] in
            //            let secondATM = ATM(tag: "secondATM")
            //            secondATM.withdraw(value: 800)
            self?.withdraw(money: 800)
        }
        
        // With init money = 1200
        // Race condition: currentMoney is [200, -600]
        // Expected: currentMoney is [200, Can't withdraw]
    }
    
    // Crash application
    func threadDeadLock() {
        NSLog("1")
        lock.lock()
        deadlockQueue.async { [weak self] in
            NSLog("2")
            self?.deadlockQueue.sync {
                NSLog("3")
            }
            NSLog("4")
        }
        
        NSLog("Finished Deadlock Test")
    }
    
    // Freeze application
    func deadLockOnLock() {
        queue.async { [weak self] in
            lockFunc(obj: self?.object1 as AnyObject) {
                Thread.sleep(forTimeInterval: 1)
                lockFunc(obj: self?.object2 as AnyObject) {
                    NSLog("released lock")
                }
            }
        }
        
        lockFunc(obj: object2 as AnyObject) {
            Thread.sleep(forTimeInterval: 1)
            lockFunc(obj: object1 as AnyObject) {
                NSLog("released lock")
            }
        }
        
        NSLog("Finished Deadlock Test")
    }
}

private extension ThreadingProblem {
    func withdraw(money: Int) {
        if currentMoney > money {
            Thread.sleep(forTimeInterval: Double.random(in: 0...2))
            currentMoney -= money
            print("You have been withdrawed \(money)円")
            print("Current money is \(currentMoney)円")
        } else {
            print("Can't withdraw: insufficent balance")
        }
        
        // Solve deadlock
        //        lockFunc(obj: value as AnyObject) {
        //            if value > number {
        //                Thread.sleep(forTimeInterval: Double.random(in: 0...2))
        //                value -= number
        //                print("\(value)")
        //            } else {
        //                print("Can't withdraw: insufficent balance")
        //            }
        //        }
    }
}

var balance = 1200
let lock = NSLock()
let serialQueue = DispatchQueue(label: "Serial Queue")
let concurrentQueue = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)


struct ATM {
    let tag: String
    func withdraw(value: Int) {
        //        concurrentQueue.async(flags: .barrier) {
        print("\(self.tag): checking if balance containing sufficent money")
        
        //        lock.lock()
        //        objc_sync_enter(balance)
        if balance > value {
            print("\(self.tag): Balance is sufficent, please wait while processing withdrawal")
            // sleeping for some random time, simulating a long process
            Thread.sleep(forTimeInterval: Double.random(in: 0...2))
            balance -= value
            print("\(self.tag): Done: \(value) has been withdrawed")
            print("\(self.tag): current balance is \(balance)")
        } else {
            print("\(self.tag): Can't withdraw: insufficent balance")
        }
        
        //        objc_sync_exit(balance)
        //        lock.unlock()
        //        }
    }
}

func lockFunc(obj: AnyObject, blk:() -> ()) {
    objc_sync_enter(obj)
    blk()
    objc_sync_exit(obj)
}
