//
//  RecentlyViewedBook+CoreDataProperties.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//
//

import Foundation
import CoreData

public extension RecentlyViewedBook {

    @nonobjc class func fetchRequest() -> NSFetchRequest<RecentlyViewedBook> {
        return NSFetchRequest<RecentlyViewedBook>(entityName: "RecentlyViewedBook")
    }

    @NSManaged var viewedAt: Date
    @NSManaged var book: Book

}

extension RecentlyViewedBook : Identifiable {}
