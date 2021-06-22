//
//  TestView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 22/06/2021.
//

import SwiftUI

struct User: Identifiable {
    var id: String
    var name: String
    var lastName: String
}

struct UserViewModel {
    
    static var sample: [User] {
        var users = [User]()
        for i in 0..<10 {
            let user = User(
                id: "\(i)",
                name: "Meesum \(i)",
                lastName: "Zaidi")
            users.append(user)
        }
        return users
    }
    
}


struct TestView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(UserViewModel.sample) { user in
                    NavigationLink.init(destination: DetailView(user: user)){
                        CellView(user: user)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.red)
            .navigationTitle("User Name")
        }
    }
}

struct CellView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text(user.name)
            Text(user.lastName)
        })
    }
}

struct DetailView: View {
    
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text(user.name)
            Text(user.lastName)
        })
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
        TestView().previewDevice("iPad (8th generation)")
    }
}
