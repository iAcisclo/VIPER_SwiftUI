//
//  DataLayer.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 13/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import Foundation
import Combine

class DataLayer {
        
    private let dataProvider: DataProvider
    private var cancellables = Set<AnyCancellable>()
    @Published var notes: [Note] = []
    
    init(provider: DataProvider) {
        self.dataProvider = provider
        setup()
    }
    
    // MARK: Private functions
    private func setup() {
        self.dataProvider.notesPublisher
        .assign(to: \.notes, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: Public functions
    func addNewNote(title: String, body: String, date: Date) {
        dataProvider.addNewNote(title: title,
                                body: body,
                                date: date)
    }
    
    func delete(_ note: Note) {
        dataProvider.delete(note)
    }
    
    func deleteAllNotes() {
        dataProvider.deleteAllNotes()
    }
}
