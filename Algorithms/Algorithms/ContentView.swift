//
//  ContentView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlgorithmsView()
                .tabItem {
                    Image(systemName: "selection.pin.in.out")
                        .font(.title2)
                    
                    Text("Алгоритмы")
                }
            
            DataStructuresView()
                .tabItem {
                    Image(systemName: "number")
                        .font(.title2)
                    
                    Text("Структуры данных")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
