//
//  DetailDataView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 05.08.2020.
//

import SwiftUI

struct DetailDataView: View {
    @State var element: HomeListType
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Hello, World!")
            }
            .navigationBarTitle(element.name, displayMode: .inline)
        }
    }
}

struct DetailDataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDataView(element: carouselDataTypes[6])
    }
}
