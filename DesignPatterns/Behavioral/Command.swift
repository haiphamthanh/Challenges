//
//  Command.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/21/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// B2: Create neccessary interface
protocol ActionCommand {
    func exec() -> Bool
}

// B3: Create Commands
class OpenAccountCommand: ActionCommand {
    func exec() -> Bool {
        print("Open new account")
        return true
    }
}

class CloseAccountCommand: ActionCommand {
    func exec() -> Bool {
        print("Close account")
        return true
    }
}

// B1: Create 脚本 to use
class BankApp {
    private let openAccountCM: ActionCommand
    private let closeAccountCM: ActionCommand
    
    init(openAccountCM: ActionCommand, closeAccountCM: ActionCommand) {
        self.openAccountCM = openAccountCM
        self.closeAccountCM = closeAccountCM
    }
    
    func openAccount() -> Bool {
        return openAccountCM.exec()
    }
    
    func closeAccount() -> Bool {
        return closeAccountCM.exec()
    }
}

// Final class
class Command {
    func main() -> Int {
        return 1
    }
}

// 脚本: Mỗi object đều có chung một phương thức là run hoặc là excution một đoạn code nào đó.
// 確認: Mỗi lần muốn sửa đổi các logic bên trong các run hoặc excution này chúng ta sẽ tác động lên phương thức, mà phương thức đó thuộc đối tượng -> vô tình làm ảnh hưởng đến cả đối tượng.
// 問題: Làm sao để giảm tác động -> chỉnh sửa cái gì thì chỉ thay đổi cái đó -> Điều này làm cho các công việc không phụ thuộc vào nhau (Tương tự như kiến trúc microservices).
// 改善： Tách việc thực thi ra làm một đối tượng, ta sẽ implement các thực thi thành các đối tượng độc lập, các object muốn sử dụng các thực thi nào chỉ cần lựa chọn và sử dụng.
    // 問題１: Sửa đổi object không ảnh hưởng thực thi. Tương tự, sửa đổi thực thi cũng không ảnh hưởng các object.
    // 問題２: Object có thể tuỳ chọn các thực thi để dùng mà không cố định, cứng nhắc.
