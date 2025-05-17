//
//  MyBook+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

extension MyBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyBook> {
        return NSFetchRequest<MyBook>(entityName: "MyBook")
    }

    @NSManaged public var savedAt: Date
    @NSManaged public var book: Book
}

extension MyBook : Identifiable {}
