//
//  Facade.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// Bài toán mua hàng
class AccountService {
    func account(email: String) {
        return print("Getting the account of \(email)")
    }
}

class PaymentService {
    func byPaypal() {
        return print("Payment by Paypal")
    }
    
    func byCreditCard() {
        return print("Payment by Credit Card")
    }
    
    func byEBanking() {
        return print("Payment by E-banking account")
    }
    
    func byCash() {
        return print("Payment by Cash")
    }
}

class ShippingService {
    func free() {
        return print("Free Shipping")
    }
    
    func standard() {
        return print("Standard Shipping")
    }
    
    func express() {
        return print("Express Shipping")
    }
}

class EmailService {
    func send(_ mailto: String) {
        return print("Send an email to \(mailto)")
    }
}

class SmsService {
    func send(_ mobilePhone: String) {
        return print("Send an message to \(mobilePhone)")
    }
}

// Facade sử dụng để tạo ra service cho SHOP
class ShopFacade {
    static let shared = ShopFacade()
    
    private let accountService: AccountService
    private let paymentService: PaymentService
    private let shippingService: ShippingService
    private let emailService: EmailService
    private let smsService: SmsService
    
    private init() {
        self.accountService = AccountService()
        self.paymentService = PaymentService()
        self.shippingService = ShippingService()
        self.emailService = EmailService()
        self.smsService = SmsService()
    }
}

extension ShopFacade {
    func buyProductByCashWithFreeShipping(email: String) {
        accountService.account(email: email)
        paymentService.byCash()
        shippingService.free()
        emailService.send(email)
        
        return print("DONE\n")
    }
    
    func buyProductByPaypalWithStandardShipping(email: String, phone: String) {
        accountService.account(email: email)
        paymentService.byPaypal()
        shippingService.standard()
        emailService.send(email)
        smsService.send(phone)
        
        return print("DONE\n")
    }
}

// Final class
class Facade {
    func main() -> Int {
        ShopFacade.shared
            .buyProductByCashWithFreeShipping(email: "pthai076@gmail.com")
        
        ShopFacade.shared
            .buyProductByPaypalWithStandardShipping(email: "pthai076@gmail.com",
                                                    phone: "0339893536")
        return 1
    }
}

// PROBLEM: Mua một sản phẩm nhưng có quá nhiều thủ tục phải hoàn thành
// BUT: không biết nên hoàn thành thủ tục như thế nào?
// SOLVE: Chỉ đưa ra cho người dùng những phương thức đơn giản, ẩn đi những phương thức rườm rà, logic code tùm lum khó hiểu.
