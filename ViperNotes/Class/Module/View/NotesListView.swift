//
//  ContentView.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import SwiftUI

struct NotesListView: View {
    
    @ObservedObject var presenter: NotesPresenter
    
    var body: some View {
        NavigationView {
            List {
              ForEach (presenter.notes, id: \.id) { item in
                Text(item.title)
              }
            }
            .navigationBarTitle("Roadtrips", displayMode: .inline)
            .navigationBarItems(trailing: presenter.addButton())
        }
        
    }
}


struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
//        NotesListView()
        Text("meh")
    }
}
