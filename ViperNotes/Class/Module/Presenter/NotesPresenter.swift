//
//  NotesPresenter.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import SwiftUI
import Combine

class NotesPresenter: ObservableObject {
 
    private var interactor: NotesInteractor
    private let router = NotesRouter()
    
    @Published var noteViewModels: [NoteViewModel] = []
    private var cancellables = Set<AnyCancellable>()

    init(interactor: NotesInteractor) {
        self.interactor = interactor
        
        interactor.$noteViewModels
        .assign(to: \.noteViewModels, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: Draw
    func addButton() -> some View {
        Button(action: addNewNote) {
          Image(systemName: "plus")
        }
    }
    
    // MARK: Events
    func addNewNote() {
      interactor.addNewNote()
    }
    
    // MARK: Navigation
    func detailView(note: NoteViewModel) -> some View {
        router.detailView(note: note)
    }
}
