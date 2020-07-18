//
//  Bridge.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// root Bank
class Bank {
    // SOLVE 2: The bank contains accounts
    private(set) var account: Account
    init(account: Account) {
        self.account = account
    }
    
    func openAccount() {
        return account.openAccount()
    }
}

// Bank groups
class TPBank: Bank {
    override func openAccount() {
        print("Open your account at TPBank is a")
        
        super.openAccount()
    }
}

class VietComBank: Bank {
    override func openAccount() {
        print("Open your account at VietComBank is a")
        
        super.openAccount()
    }
}

// SOLVE 1: Make a Account group
protocol Account {
    func openAccount()
}

class CheckingAccount: Account {
    func openAccount() {
        print("Checking account")
    }
}

class SavingAccount: Account {
    func openAccount() {
        print("Saving account")
    }
}

// PROBLEM: When we make new bank, we also have checking and saving account
// Tons of class wil be created
// SOLVE: Group saving and checking to Account group and move out of Bank

// Final class
class Bridge {
    func main() -> Int {
        let ckAccount = CheckingAccount()
        let svAccount = SavingAccount()
        
        let vietCBank = VietComBank(account: ckAccount)
        let tpBank = TPBank(account: svAccount)
        
        vietCBank.openAccount()
        tpBank.openAccount()
        
        return 1
    }
}
