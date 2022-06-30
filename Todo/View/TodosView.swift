//
//  TodosView.swift
//  Todo
//
//  Created by ogura on 2022/07/01.
//

import Firebase
import SwiftUI

struct TodosView: View {
    
    @State var todos = [Todo]()
    
    var body: some View {
        List {
            ForEach(todos, id: \.id) { todo in
                NavigationLink {
                    DetailView(todo: $todos[todos.firstIndex(where: { $0.id == todo.id })!])
                } label: {
                    HStack {
                        Text(todo.title)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Text(dateFormat(createdAt: todo.createdAt))
                            .font(.system(size: 12))
                    }
                }
            }.onDelete(perform: delete)
        }
        .navigationTitle("Todos")
        .onAppear {
            fetchTodos()
        }
    }
    
    func fetchTodos() {
        Firestore.firestore().collection("todos").getDocuments { querySnapshot, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            todos = querySnapshot!.documents.map { Todo.init(data: $0.data()) }
            todos = todos.sorted(by: {
                $0.createdAt.compare($1.createdAt) == .orderedDescending
            })
        }
    }
    
    func delete(offsets: IndexSet) {
        let id = todos[offsets.last!].id
        Firestore.firestore().collection("todos").document(id).delete { error in
            if let error = error {
                print("error: \(error)")
                return
            }
            todos.remove(atOffsets: offsets)
        }
    }
    
    func dateFormat(createdAt: Timestamp) -> String {
        let date = createdAt.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/M/d hh:mm:ss"
        return dateFormatter.string(from: date)
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView()
    }
}
