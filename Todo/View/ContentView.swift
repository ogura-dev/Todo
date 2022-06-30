//
//  ContentView.swift
//  Todo
//
//  Created by ogura on 2022/06/30.
//

import Firebase
import SwiftUI

struct ContentView: View {
    
    @State var todo = Todo(data: [
        "id": UUID().uuidString,
        "title": "",
        "detail": "",
        "timestamp": Timestamp()
    ])
    
    var body: some View {
        NavigationView {
            TodosView()
                .toolbar {
                    NavigationLink {
                        DetailView(todo: $todo)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
