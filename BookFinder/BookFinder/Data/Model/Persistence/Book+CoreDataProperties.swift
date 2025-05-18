//
//  Book+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String
    @NSManaged public var contents: String
    @NSManaged public var url: String
    @NSManaged public var isbn: String
    @NSManaged public var datetime: String // Date 타입으로 변경
    @NSManaged public var authors: [String]
    @NSManaged public var publisher: String
    @NSManaged public var translators: [String]?
    @NSManaged public var price: Int32
    @NSManaged public var salePrice: Int32
    @NSManaged public var thumbnail: String
    @NSManaged public var status: String
    @NSManaged public var myBooks: NSSet
    @NSManaged public var recentlyViewdBooks: NSSet
}

// MARK: Generated accessors for myBooks
extension Book {

    @objc(addMyBooksObject:)
    @NSManaged public func addToMyBooks(_ value: MyBook)

    @objc(removeMyBooksObject:)
    @NSManaged public func removeFromMyBooks(_ value: MyBook)

    @objc(addMyBooks:)
    @NSManaged public func addToMyBooks(_ values: NSSet)

    @objc(removeMyBooks:)
    @NSManaged public func removeFromMyBooks(_ values: NSSet)

}

// MARK: Generated accessors for recentlyViewdBooks
extension Book {

    @objc(addRecentlyViewdBooksObject:)
    @NSManaged public func addToRecentlyViewdBooks(_ value: RecentlyViewedBook)

    @objc(removeRecentlyViewdBooksObject:)
    @NSManaged public func removeFromRecentlyViewdBooks(_ value: RecentlyViewedBook)

    @objc(addRecentlyViewdBooks:)
    @NSManaged public func addToRecentlyViewdBooks(_ values: NSSet)

    @objc(removeRecentlyViewdBooks:)
    @NSManaged public func removeFromRecentlyViewdBooks(_ values: NSSet)

}

extension Book : Identifiable {}
