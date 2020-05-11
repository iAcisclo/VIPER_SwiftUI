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
        
    private let persistence: CoreDataStack
    @Published var notes: [Note] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(persistence: CoreDataStack) {
        self.persistence = persistence
    }

    func fetch() -> AnyPublisher<[Note],Error>  {
        return persistence.fetch()
    }
    
    func addNewNote(title: String, body: String, date: Date) {
        persistence.addNewNote(title: title,
                               body: body,
                               date: date)
    }
    
    func removeAll() {
        persistence.removeAllNotes()
    }
}
