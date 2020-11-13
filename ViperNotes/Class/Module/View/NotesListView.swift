//
//  ContentView.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
import SwiftUI

struct NotesListView: View {
    
    @StateObject var presenter: NotesPresenter
    
    var body: some View {
        NavigationView {
            List {
              ForEach (presenter.noteViewModels, id: \.id) { item in
                NavigationLink(item.title, destination: self.presenter.detailView(note: item))
              }
              .onDelete(perform: presenter.delete)
            }
            .navigationBarTitle("Notes", displayMode: .inline)
            .navigationBarItems(trailing:
                presenter.topButton()
            )
        }
    }
}
