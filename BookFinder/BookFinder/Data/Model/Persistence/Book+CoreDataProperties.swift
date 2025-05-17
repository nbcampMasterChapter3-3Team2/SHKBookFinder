//
//  Book+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

public extension Book {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged var title: String
    @NSManaged var contents: String
    @NSManaged var url: String
    @NSManaged var isbn: String
    @NSManaged var datetime: String // Date 타입으로 변경
    @NSManaged var authors: [String]
    @NSManaged var publisher: String
    @NSManaged var translators: [String]
    @NSManaged var price: Int32
    @NSManaged var sale_price: Int32
    @NSManaged var thumbnail: String
    @NSManaged var status: String

}

extension Book : Identifiable {}
