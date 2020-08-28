//
//  AlgorithmsView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

struct AlgorithmsView: View {
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(carouselDataTypes, id: \.id) { element in
                                    Button(action: {
                                        isPresented.toggle()
                                    }, label: {
                                        CarouselCellView(element: element)
                                    })
                                    .sheet(isPresented: $isPresented) {
                                        DetailDataView(element: element)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Общее")) {
                        ForEach(infoAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                    
                    Section(header: Text("Начало")) {
                        ForEach(startingAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                    
                    Section(header: Text("Сортировки")) {
                        ForEach(sortAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                    
                    Section(header: Text("Поиск")) {
                        ForEach(searchAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                    
                    Section(header: Text("Поиск в строке")) {
                        ForEach(stringSearchAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                    
                    Section(header: Text("Алгоритмы на графах")) {
                        ForEach(graphsAlgorithms) { element in
                            Button(action: {
                                    isPresented.toggle()
                            }, label: {
                                ListCellView(element: element)
                            })
                            .sheet(isPresented: $isPresented) {
                                DetailDataView(element: element)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
                .navigationBarTitle("Алгоритмы")
        }
    }
}

struct AlgorithmsView_Previews: PreviewProvider {
    static var previews: some View {
        AlgorithmsView()
    }
}
