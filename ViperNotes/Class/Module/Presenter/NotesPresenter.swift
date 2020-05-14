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
 
    private let interactor: NotesInteractor
    private let router = NotesRouter()
    private var cancellables = Set<AnyCancellable>()
    @Published var noteViewModels: [NoteViewModel] = []

    init(interactor: NotesInteractor) {
        self.interactor = interactor
        
        interactor.$noteViewModels
        .assign(to: \.noteViewModels, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: Draw
    func topButton() -> some View {
        if interactor.showAddButton() {
            return Button(action: interactor.addNewNote) {
              Image(systemName: "plus")
            }
        } else {
            return Button(action: interactor.deleteAllNotes) {
              Image(systemName: "trash")
            }
        }
    }
    
    // MARK: Events
    func addNewNote() {
        interactor.addNewNote()
    }
    
    func delete(_ index: IndexSet) {
        interactor.deleteNote(index)
    }
    
    // MARK: Navigation
    func detailView(note: NoteViewModel) -> some View {
        router.detailView(note: note)
    }
}
