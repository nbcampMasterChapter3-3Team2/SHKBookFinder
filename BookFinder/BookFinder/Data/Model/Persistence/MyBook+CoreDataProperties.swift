//
//  MyBook+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

public extension MyBook {

    @nonobjc class func fetchRequest() -> NSFetchRequest<MyBook> {
        return NSFetchRequest<MyBook>(entityName: "MyBook")
    }

    @NSManaged var savedAt: Date
    @NSManaged var book: Book
}

extension MyBook : Identifiable {}
