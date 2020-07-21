//
//  Visitor.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/21/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation
class Book {
    func desc() {
        print("This is \(self) book")
    }
}

class HistoryBook: Book {
}

class ProgrammingBook: Book {
}

class ArtistBook: Book {
}

class Customer {
    func buy(book: Book) {
        print("\(#function) Book was called")
        return book.desc()
    }
    
    func buy(book: HistoryBook) {
        print("\(#function) HistoryBook was called")
        return book.desc()
    }
    
    func buy(book: ProgrammingBook) {
        print("\(#function) ProgrammingBook was called")
        return book.desc()
    }
    
    func buy(book: ArtistBook) {
        print("\(#function) ArtistBook was called")
        return book.desc()
    }
}

// Final calls
class Visitor {
    func main() -> Int {
        let cus = Customer()
        
        let book: Book = HistoryBook()
        cus.buy(book: book)
        
        return 1
    }
}


// PROBLEM: func buy(book: Book) was called instead of calling func buy(book: HistoryBook)
