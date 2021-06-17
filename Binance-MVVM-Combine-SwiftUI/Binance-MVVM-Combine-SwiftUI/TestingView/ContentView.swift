//
//  ContentView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 17/06/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store

    var body: some View {
        VStack {
            Button("Rename") {
                if let book = store.items.first {
                    store.changeTitle(for: book, newTitle: "Lord of the Rings")
                }
            }

            List(store.items, id: \.self) { book in
                Text(book.title)
            }
            
        }
    }
}

class Book: NSObject, ObservableObject {
    @Published var title: String

    init(title: String) {
        self.title = title
    }
}

class Store: NSObject, ObservableObject {
    static var sample: Store {
        let items = [Book(title: "Harry Potter 1"),
                     Book(title: "Harry Potter 2"),
                     Book(title: "Harry Potter 3")]
        return Store(items: items)
    }

    @Published var items: [Book]

    init(items: [Book]) {
        self.items = items
    }
    
    func changeTitle(for book: Book, newTitle: String) {
       objectWillChange.send()
       book.title = newTitle
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store.sample
        ContentView(store: store)
    }
}
