//
//  Decorator.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// Base class
class Employee {
    func doTask() {
    }
    
    func join() {
    }
    
    func terminate() {
    }
}

// Class based role
class TeamMember: Employee {
    func reportTask() {
    }
    
    func coordinateWithOthers() {
    }
}

class TeamLeader: Employee {
    func planning() {
    }
    
    func motivate() {
    }
    
    func monitor() {
    }
}

class Manager: Employee {
    func createRequirement() {
    }
    
    func assignTask() {
    }
    
    func manageProgress() {
    }
}

// PROBLEM: Mỗi lần nhân viên muốn thăng cấp cần phải xoá đối tượng cũ và tạo một đối tượng mới. Thực tế là nhân viên có thể làm cả 2 hoặc 3 nhiệm vụ.
// BUT: Điều đó có nghĩa là đối tượng cũ nếu muốn thăng cấp phải xoá đi và tạo đối tượng mới. Nếu làm nhiều nhiệm vụ thì phải tạo nhiều đối tượng -> điều này là phi lý.
// SOLVE: Thiết kế một lớp nhân viên sao cho có thể thêm các vai trò vào lớp nhân viên làm không làm thay đổi cấu trúc(các role khác nhau chỉ mang tính trang trí cho đối tượng nhân viên).

// Final class
class Decorator {
    func main() -> Int {
        return 1
    }
}
