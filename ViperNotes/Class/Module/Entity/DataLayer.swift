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
        
    private let persistence: CoreDataStack
    private var cancellables = Set<AnyCancellable>()
    @Published var notes: [Note] = []
    
    init(persistence: CoreDataStack) {
        self.persistence = persistence
        setup()
    }
    
    // MARK: Private functions
    private func setup() {
        self.persistence.$notes
        .assign(to: \.notes, on: self)
        .store(in: &cancellables)
    }
    
    // MARK: Public functions
    func addNewNote(title: String, body: String, date: Date) {
        persistence.addNewNote(title: title,
                               body: body,
                               date: date)
    }
}
