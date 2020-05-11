//
//  NotesInteractor.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import Foundation
import Combine

class NotesInteractor {
    
    private let formatter = DateFormatter()
    private let model: DataLayer
    
    private var cancellables = Set<AnyCancellable>()
    @Published var noteViewModels: [NoteViewModel] = []

    init (model: DataLayer) {
        self.model = model
        load()
    }

    func load() {
        model.fetch()
        .map({ notes -> [NoteViewModel] in
            return notes.map{
                let noteViewModel = NoteViewModel(id: $0.id)
                noteViewModel.title = $0.title
                noteViewModel.body = $0.body
                noteViewModel.date = self.formatter.string(from: $0.date)
                return noteViewModel
            }
        })
        .replaceError(with: [])
        .assign(to: \.noteViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addNewNote() {
        model.addNewNote(title: "Note \(noteViewModels.count)", body: "Note body", date: Date() )
        load()
    }
}
