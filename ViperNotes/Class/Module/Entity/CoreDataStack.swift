//
//  Persistence.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 08/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import SwiftUI
import Combine
import CoreData


class CoreDataStack {
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    private func allNotes() -> [Note] {
        do {
            let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
            return try self.managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return []
        }
    }
    
    private func save() {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    
    // Public
    func fetch() -> AnyPublisher<[Note],Error>  {
        
        return Future<[Note],Error> { promise in
            DispatchQueue.main.async {
                do {
                    let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
                    let results = try self.managedObjectContext.fetch(fetchRequest)
                    promise(.success(results))
                } catch let error as NSError {
                    print("\(error), \(error.userInfo)")
                    promise(.failure(error))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func addNewNote(title: String, body: String, date: Date) {
        let note = Note(context: managedObjectContext)
        note.id = UUID()
        note.title = title
        note.body = body
        note.date = date
        save()
    }
    
    func removeAllNotes() {
        allNotes().forEach { object in
            managedObjectContext.delete(object)
        }
        save()
    }
}
