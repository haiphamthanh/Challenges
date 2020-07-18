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
}

// TPBank and Accounts
class TPBank: Bank {
}

class TPBankCheckingAccount: TPBank {
}

class TPBankSavingAccount: TPBank {
}

// VietComBank and Account
class VietComBank: Bank {
}

class VietComBankCheckingAccount: VietComBank {
}

class VietComBankSavingAccount: VietComBank {
}

// PROBLEM: When we make new bank, we also have checking and saving account
// Tons of class wil be created
// SOLVE: Group saving and checking to Account group and move out of Bank

// Final class
class Bridge {
    func main() -> Int {
        return 1
    }
}
