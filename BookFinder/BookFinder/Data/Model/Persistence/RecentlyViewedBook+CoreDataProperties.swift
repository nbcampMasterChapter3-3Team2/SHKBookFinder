//
//  RecentlyViewedBook+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

extension RecentlyViewedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentlyViewedBook> {
        return NSFetchRequest<RecentlyViewedBook>(entityName: "RecentlyViewedBook")
    }

    @NSManaged public var viewedAt: Date
    @NSManaged public var book: Book
}

extension RecentlyViewedBook : Identifiable {}
