//
//  DataStructuresView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

enum ButtonLabel {
    case carousel
    case list
}

struct DataStructuresView: View {
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                SectionView(label: .carousel, elements: carouselDataTypes)
                            }
                        }
                    }
                    
                    Section(header: Text("Общее")) {
                        SectionView(label: .list, elements: infoDataStructures)
                    }
                    
                    Section(header: Text(carouselDataTypes[0].name)) {
                        SectionView(label: .list, elements: arraysTypes)
                    }
                    
                    Section(header: Text(carouselDataTypes[1].name)) {
                        SectionView(label: .list, elements: queuesType)
                    }
                    
                    Section(header: Text(carouselDataTypes[2].name)) {
                        SectionView(label: .list, elements: listsType)
                    }
                    
                    Section(header: Text(carouselDataTypes[3].name)) {
                        SectionView(label: .list, elements: treesType)
                    }
                    
                    Section(header: Text(carouselDataTypes[4].name)) {
                        SectionView(label: .list, elements: hashesType)
                    }
                    
                    Section(header: Text(carouselDataTypes[5].name)) {
                        SectionView(label: .list, elements: setsType)
                    }
                    
                    Section(header: Text(carouselDataTypes[6].name)) {
                        SectionView(label: .list, elements: graphsType)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Структуры данных")
        }
    }
}

struct SectionView: View {
    @State var label: ButtonLabel
    @State var elements: [HomeListType]
    
    @State var isPresented = false
    
    var body: some View {
        ForEach(elements) { element in
            Button(action: {
                isPresented.toggle()
            }, label: {
                if label == .carousel {
                    CarouselCellView(element: element)
                } else {
                    ListCellView(element: element)
                }
            })
            .sheet(isPresented: $isPresented) {
                DetailDataView(element: element)
            }
        }
    }
}

struct DataStructuresView_Previews: PreviewProvider {
    static var previews: some View {
        DataStructuresView()
    }
}
