//
//  Decorator.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

/*
import Foundation

// Abstract class
class EmployeeComponent {
    func fullName() -> String {
        fatalError("Implement in subclass")
    }
    
    func doTask() {
        fatalError("Implement in subclass")
    }
    
    func join() {
        fatalError("Implement in subclass")
    }
    
    func terminate() {
        fatalError("Implement in subclass")
    }
}

// Basic informations about employee
class EmployeeConcreteComponent: EmployeeComponent {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    override func fullName() -> String {
        return name
    }
    
    override func doTask() {
        // Unassigned task
    }
    
    override func join() {
    }
    
    override func terminate() {
    }
}

//SOLVE 1: Decorator phải được thiết kế giống theo kiểu đệ quy vô tận
class EmployeeDecorator: EmployeeComponent {
    //SOLVE 2: IMPORTANT
    private let employee: EmployeeComponent
    init(employee: EmployeeComponent) {
        self.employee = employee
    }
    
    override func doTask() {
        return employee.doTask()
    }
    
    override func join() {
        return employee.join()
    }
    
    override func terminate() {
        return employee.terminate()
    }
}

// Add more behavior into object
class TeamMember: EmployeeDecorator {
    func reportTask() {
    }
    
    func coordinateWithOthers() {
    }
    
    override func doTask() {
        super.doTask()
        
        reportTask()
        return coordinateWithOthers()
    }
}

class TeamLeader: EmployeeDecorator {
    func planning() {
    }
    
    func motivate() {
    }
    
    func monitor() {
    }
    
    override func doTask() {
        super.doTask()
        
        planning()
        motivate()
        return monitor()
    }
}

class Manager: EmployeeDecorator {
    func createRequirement() {
    }
    
    func assignTask() {
    }
    
    func manageProgress() {
    }
    
    override func doTask() {
        super.doTask()
        
        createRequirement()
        assignTask()
        return manageProgress()
    }
}

// PROBLEM: Mỗi lần nhân viên muốn thăng cấp cần phải xoá đối tượng cũ và tạo một đối tượng mới. Thực tế là nhân viên có thể làm cả 2 hoặc 3 nhiệm vụ.
// BUT: Điều đó có nghĩa là đối tượng cũ nếu muốn thăng cấp phải xoá đi và tạo đối tượng mới. Nếu làm nhiều nhiệm vụ thì phải tạo nhiều đối tượng -> điều này là phi lý.
// SOLVE: Thiết kế một lớp nhân viên sao cho có thể thêm các vai trò vào lớp nhân viên làm không làm thay đổi cấu trúc(các role khác nhau chỉ mang tính trang trí cho đối tượng nhân viên).

// Final class
class Decorator {
    func main() -> Int {
        
        // The first year is a fresher
        let employee = EmployeeConcreteComponent(name: "Jackie")
        
        // The first year is a member
        let member = TeamMember(employee: employee)
        
        // Second year is a teamleader
        let leader = TeamLeader(employee: member)
        
        // Third year is a manager
        let manager = Manager(employee: leader)
        
        // Do task as level
        employee.doTask()
        leader.doTask()
        manager.doTask()
        return 1
    }
}
*/
