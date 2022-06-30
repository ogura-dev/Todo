//
//  DetailView.swift
//  Todo
//
//  Created by ogura on 2022/06/30.
//

import Firebase
import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var todo: Todo
    
    @State var title = ""
    @State var detail = ""
    
    var body: some View {
        VStack(spacing: 50) {
            TextField("title", text: $title)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 2)
                )
            ZStack {
                TextEditor(text: $detail)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                    )
                if detail.isEmpty {
                    VStack {
                        HStack {
                            Text("detail")
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            Spacer()
                        }
                        Spacer()
                    }.padding(10)
                }
            }
        }
        .padding()
        .toolbar {
            Button {
                let data = [
                    "id": UUID().uuidString,
                    "title": title,
                    "detail": detail,
                    "timestamp": Timestamp(),
                ] as [String : Any]
                if todo.title.isEmpty && todo.detail.isEmpty {
                    addTodo(data: data)
                } else {
                    updateTodo(data: data)
                }
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }
            .disabled(title.isEmpty || detail.isEmpty || title == todo.title && detail == todo.detail)
            .opacity(title.isEmpty || detail.isEmpty || title == todo.title && detail == todo.detail ? 0.3 : 1)
        }
        .onAppear {
            title = todo.title
            detail = todo.detail
        }
    }
    
    func addTodo(data: [String: Any]) {
        Firestore.firestore().collection("todos").document(data["id"] as! String).setData(data) { error in
            if let error = error {
                print("error: \(error)")
                return
            }
        }
    }
    
    func updateTodo(data: [String: Any]) {
        Firestore.firestore().collection("todos").document(todo.id).updateData(data) { error in
            if let error = error {
                print("error: \(error)")
                return
            }
        }
    }
}

//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
