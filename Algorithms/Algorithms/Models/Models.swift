//
//  Models.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

struct HomeListType: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var isSystemImage: Bool
    var color: Color
    var text: String?
}
