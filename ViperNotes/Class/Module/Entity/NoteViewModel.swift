//
//  Note.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import Foundation
import Combine

final class NoteViewModel {
    
    var title: String = ""
    var body: String = ""
    var date: String = ""
    let id: UUID

    init(id: UUID) {
        self.id = id
    }
}
