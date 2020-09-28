//
//  ContentView.swift
//  Tasks App
//
//  Created by Даниил Храповицкий on 28.09.2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Home()
    }
}
