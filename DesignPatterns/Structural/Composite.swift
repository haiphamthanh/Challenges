//
//  Composite.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/18/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

// PROBLEM: tree folder in os system
protocol FileComponent {
    func showProperty()
    var size: Int { get }
}

// File
class File {
    private let name: String
    
    init(name: String = "Unknown") {
        self.name = name
    }
}
extension File: FileComponent {
    func showProperty() {
        print("File \(name) size is \(size)")
    }
    
    var size: Int {
        return 20
    }
}

//Folder
class Folder {
    private let name: String
    private var files = [File]()
    private var folders = [Folder]()
    
    init(name: String = "Unknown") {
        self.name = name
    }
    
    func add(file: File) {
        return files.append(file)
    }
}
extension Folder: FileComponent {
    func showProperty() {
        print("Folder \(name) total file is \(files.count) size is \(size)")
    }
    
    var size: Int {
        return files.map({ $0.size }).reduce(0, +)
    }
}


// Final class
class Composite {
    func main() -> Int {
        let testFile = File(name: "Test")
        let homeFolder = Folder(name: "Home")
        
        homeFolder.add(file: testFile)
        homeFolder.add(file: testFile)
        homeFolder.add(file: testFile)
        
        testFile.showProperty()
        homeFolder.showProperty()
        
        return 1
    }
}
