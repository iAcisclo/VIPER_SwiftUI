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
    
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(entity: Note.entity(), sortDescriptors: []) var notes: FetchedResults<Note>
    
    var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func load() -> AnyPublisher<[Note],Error>  {
        
        return Future<[Note],Error> { promise in
            DispatchQueue.main.async {
              
                
                
//                let fetchRequest : @FetchRequest = Note.fe
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
    
    func save() {
        var r: [Note]
        do {
            let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
            let results = try self.managedObjectContext.fetch(fetchRequest)
            r = results
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            r = []
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: self.managedObjectContext)
        let notification = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        notification.setValue("title \(r.count)", forKey: "title")
        notification.setValue("body", forKey: "body")
        notification.setValue(Date(), forKey: "date")
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func removeAll() {
        
        var objects: [NSManagedObject]
        
        let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            objects = results
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            objects = []
        }
        
        objects.forEach { object in
            managedObjectContext.delete(object)
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
}
