//
//  Visitor.swift
//  DesignPatterns
//
//  Created by HaiKaito on 7/21/20.
//  Copyright © 2020 HaiKaito. All rights reserved.
//

import Foundation

protocol CustomerBehavior {
    func buy(book: Book)
    func buy(book: HistoryBook)
    func buy(book: ProgrammingBook)
    func buy(book: ArtistBook)
}

protocol BookBehavior {
    func accept(cus: CustomerBehavior)
}

class Book: BookBehavior {
    func accept(cus: CustomerBehavior) {
        return cus.buy(book: self)
    }
    
    func desc() {
        print("This is \(self) book")
    }
}

class HistoryBook: Book {
    override func accept(cus: CustomerBehavior) {
        return cus.buy(book: self)
    }
}

class ProgrammingBook: Book {
    override func accept(cus: CustomerBehavior) {
        return cus.buy(book: self)
    }
}

class ArtistBook: Book {
    override func accept(cus: CustomerBehavior) {
        return cus.buy(book: self)
    }
}

class Customer: CustomerBehavior {
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
        let cus: CustomerBehavior = Customer()
        
        // OLD:
        print("Buy in old way")
        let book: Book = HistoryBook()
        cus.buy(book: book)
        
        print("\n")
        
        // NEW:
        print("Buy in new way")
        let newBook: Book = HistoryBook()
        newBook.accept(cus: cus)
        
        return 1
    }
}


// PROBLEM: func buy(book: Book) was called instead of calling func buy(book: HistoryBook)
