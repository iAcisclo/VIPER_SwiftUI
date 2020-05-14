//
//  NotesRouter.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import Foundation
import CoreData
import SwiftUI

struct NotesRouter {
    
    func listView(context: NSManagedObjectContext) -> some View {
        
        let persistence = CoreDataStack(context: context)
        let dataLayer = DataLayer(provider: persistence)
        let contentView = NotesListView(presenter: NotesPresenter(interactor: NotesInteractor(model: dataLayer)))
        
        return contentView
    }
    
    func detailView(note: NoteViewModel) -> some View {
        NotesDetailView(note: note)
    }
}
