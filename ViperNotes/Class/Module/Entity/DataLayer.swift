//
//  DataManager.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 08/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import SwiftUI
import Combine

class DataLayer {
        
    private let provider: DataProvider
    private var cancellables = Set<AnyCancellable>()
    @Published var notes: [Note] = []
    
    init(persistence: DataProvider) {
        self.provider = persistence
        setup()
    }
    
    private func setup() {
        self.provider.notesPublisher
        .assign(to: \.notes, on: self)
        .store(in: &cancellables)
    }
}

extension DataLayer: DataProvider {
    var notesPublisher: Published<[Note]>.Publisher {
        $notes
    }
    
    func addNewNote(title: String, body: String, date: Date) {
        provider.addNewNote(title: title,
                            body: body,
                            date: date)
    }
       
    func delete(_ note: Note) {
        provider.delete(note)
    }
}
