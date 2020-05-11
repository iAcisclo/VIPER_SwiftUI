//
//  NotesInteractor.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import Foundation
import SwiftUI

class NotesInteractor {
    
    let model: DataLayer

    init (model: DataLayer) {
      self.model = model
    }

    func addNewNote() {
        model.save()
        model.load()
    }
}
