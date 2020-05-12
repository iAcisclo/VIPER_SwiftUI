//
//  NotesDetailView.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import SwiftUI

struct NotesDetailView: View {
    
    var note: NoteViewModel
    
    var body: some View {
        VStack() {
            Text("Title: \(note.title)")
            Text("Body: \(note.body)")
            Spacer()
        }
        .navigationBarTitle(note.date)
    }
}
