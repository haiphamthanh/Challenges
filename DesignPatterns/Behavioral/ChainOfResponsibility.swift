//
//  ChainOfResponsibility.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/21/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// Execution interface
protocol ComponentWithContextualAction {
    func action()
}


// Actors
class Base: ComponentWithContextualAction {
    private let nextContactor: ComponentWithContextualAction?
    init(nextContactor: ComponentWithContextualAction? = nil) {
        self.nextContactor = nextContactor
    }
    
    // Must be overrided in subclass
    // Need to call at last
    func action() {
        print("-> Job've done ----- goto next job -----")
        nextContactor?.action()
    }
}

class Member: Base {
    override func action() {
        defer { super.action() }
        
        // Do something special for member
        print("Member develop software")
    }
}
class Leader: Base {
    override func action() {
        defer { super.action() }
        
        // Do something special for leader
        print("Leader report software processing")
    }
}
class Manager: Base {
    override func action() {
        defer { super.action() }
        
        // Do something special for manager
        print("Manager manage schedule")
    }
}
class Chief: Base {
    override func action() {
        defer { super.action() }
        
        // Do something special for chief
        print("Chief track profit")
    }
}

// Final class
class ChainOfResponsibility {
    func main() -> Int {
        
        let chief = Chief()
        let manager = Manager(nextContactor: chief)
        let leader = Leader(nextContactor: manager)
        let member = Member(nextContactor: leader)
        
        member.action()
        
        return 1
    }
}

// 脚本: Chúng ta có một chuỗi các nhiệm vụ cần thực hiện nhưng tại 1 thời điểm chỉ thực hiện một công việc -> Người quản lý kêu A làm, A làm xong báo người quản lý -> Người quản lý lại bảo B làm,... công việc cứ như vậy tiếp diễn cho đến hết.
// 確認: Người quản lý phải tương tác với tất cả nhân viên để điều phối công việc.
// 問題: Tốn rất nhiều effort của người quản lý + Nếu thay người quản lý thì toàn bộ công việc bị đình chỉ.
// 改善： Mỗi người chỉ nên biết thông tin của người tiếp theo cần làm trong chuỗi nhiệm vụ.
    // 問題１: Không dồn effort quản lý cho một người mà chuyển sang cho mỗi người.
    // 問題２: Nếu một người nghỉ thì chỉ ảnh hưởng công đoạn của người đó.
    // 特別：
        // Dễ dàng control được các công đoạn nếu phát sinh lỗi vì các công đoạn được sắp xếp thành một mắc xích nên sẽ dễ dàng trong việc truy vết.
        // Chi phí để thay một người quản lý sẽ cao hơn nhiều so với chi phí thay một nhân viên trong một công đoạn bất kì.
