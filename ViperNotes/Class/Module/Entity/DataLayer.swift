//
//  DataManager.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 08/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import Foundation
import SwiftUI
import Combine

class DataLayer {
    
//    private let persistence = CoreDataStack()
    
    private let persistence: CoreDataStack
    init(persistence: CoreDataStack) {
        self.persistence = persistence
    }
    
    @Published var notes: [NoteViewModel] = []
    
    private var cancellables = Set<AnyCancellable>()

    func load() {
        
        let formatter = DateFormatter()
        
      persistence.load()
        .replaceError(with: [])
        .map({ notes -> [NoteViewModel] in
            return notes.map{
                let noteViewModel = NoteViewModel(id: $0.id ?? UUID())
                noteViewModel.title = $0.title ?? ""
                noteViewModel.body = $0.body ?? ""
                noteViewModel.date = formatter.string(from: $0.date ?? Date())
                return noteViewModel
            }
        })
        .assign(to: \.notes, on: self)
        .store(in: &cancellables)
    }
    
    func save() {
        persistence.save()
    }
    
    func removeAll() {
        persistence.removeAll()
    }
}
