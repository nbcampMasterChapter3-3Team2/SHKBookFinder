//
//  PersistenceController.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import CoreData

final class PersistenceController {

    // MARK: - Properties

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Initializer, Deinit, requiered

    init() {
        container = NSPersistentContainer(name: "BookFinder")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // MARK: - Methods

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Save error:  \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
