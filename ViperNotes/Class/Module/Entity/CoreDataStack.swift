//
//  Persistence.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 08/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import Combine
import CoreData

protocol DataProvider {
    var notesPublisher: Published<[Note]>.Publisher { get }
    func addNewNote(title: String, body: String, date: Date)
    func delete(_ note: Note)
    func deleteAllNotes()
}

class CoreDataStack {
    
    private var managedObjectContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    @Published var notes: [Note] = []
    

    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        publish()
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
        publish()
    }
    
    private func publish() {
        notes = allNotes()
    }
}

extension CoreDataStack: DataProvider {
    
    var notesPublisher: Published<[Note]>.Publisher {
        $notes
    }
    
    func addNewNote(title: String, body: String, date: Date) {
        let note = Note(context: managedObjectContext)
        note.id = UUID()
        note.title = title
        note.body = body
        note.date = date
        save()
    }
       
    func delete(_ note: Note) {
        self.managedObjectContext.delete(note)
        save()
    }
    
    func deleteAllNotes() {
        allNotes().forEach { object in
            managedObjectContext.delete(object)
        }
        save()
    }
}
