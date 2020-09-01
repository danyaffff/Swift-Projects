//
//  ContentView.swift
//  SailsJS
//
//  Created by Даниил Храповицкий on 01.09.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("SailsJS")
        }
    }
    
}

struct Home: View {
    @StateObject var data = Server()
    
    var body: some View {
        VStack {
            if data.users.isEmpty {
                if data.noData {
                    Text("Нет пользователей")
                } else {
                    ProgressView()
                }
            } else {
                List {
                    ForEach(data.users, id: \.id) { user in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(user.username)
                                .fontWeight(.bold)
                            
                            Text(user.password)
                                .font(.caption)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            data.deleteUser(id: data.users[index].id)
                        }
                    })
                }
            }
        }
        .toolbar() {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: data.newUser, label: {
                    Text("Создать")
                })
            }
        }
    }
}

class Server: ObservableObject {
    @Published var users: [User] = []
    @Published var noData = false
    
    let url = "http://localhost:1337/user"
    
    init() {
        getUsers()
    }
    
    func setUser(username: String, password: String) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        request.addValue(username, forHTTPHeaderField: "username")
        request.addValue(password, forHTTPHeaderField: "password")
        
        session.dataTask(with: request) { (data, _, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let response = data else { return }
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "PASS" {
                self.getUsers()
            } else {
                print("Ошибка записи, де-то ты напортачил")
            }
        }
        .resume()
    }
    
    func getUsers() {
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, _, err) in
            if err != nil {
                print(err!.localizedDescription)
                self.noData.toggle()
                return
            }
            
            guard let response = data else { return }
            
            let users = try! JSONDecoder().decode([User].self, from: response)
            
            DispatchQueue.main.async {
                self.users = users
                
                if users.isEmpty {
                    self.noData.toggle()
                }
            }
        }
        .resume()
    }
    
    func deleteUser(id: Int) {
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "DELETE"
        request.addValue("\(id)", forHTTPHeaderField: "id")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, _, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let response = data else { return }
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "PASS" {
                DispatchQueue.main.async {
                    self.users.removeAll { (user) -> Bool in
                        return user.id == id
                    }
                }
            } else {
                print("Не смог удолить")
            }
        }
        .resume()
    }
    
    func newUser() {
        let alert = UIAlertController(title: "Новый пользователь", message: "Создать нового пользователя", preferredStyle: .alert)
        
        alert.addTextField { (username) in
            username.placeholder = "Имя пользователя"
        }
        
        alert.addTextField { (password) in
            password.placeholder = "Пароль"
            password.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        alert.addAction(UIAlertAction(title: "Создать", style: .destructive, handler: { (_) in
            self.setUser(username: alert.textFields![0].text!, password: alert.textFields![1].text!)
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

struct User: Decodable {
    var id: Int
    var username: String
    var password: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
