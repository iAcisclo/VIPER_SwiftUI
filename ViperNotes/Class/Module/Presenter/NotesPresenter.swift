//
//  NotesPresenter.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NotesPresenter: ObservableObject {
 
    private let interactor: NotesInteractor
    private let router = NotesRouter()
    
    @Published var notes: [NoteViewModel] = []
    private var cancellables = Set<AnyCancellable>()

    
    init(interactor: NotesInteractor) {
        self.interactor = interactor
        interactor.model.$notes
        .assign(to: \.notes, on: self)
        .store(in: &cancellables)
    }
    
    func addButton() -> some View {
        Button(action: addNewNote) {
          Image(systemName: "plus")
        }
    }
    
    func addNewNote() {
      interactor.addNewNote()
    }
}
