//
//  Home.swift
//  Tasks App
//
//  Created by Даниил Храповицкий on 28.09.2020.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            VStack(spacing: 0) {
                HStack {
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                if results.isEmpty {
                    Spacer()
                    
                    Text("No Tasks")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(results) { task in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu {
                                    Button(action: {
                                        homeData.editItem(item: task)
                                    }, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            Button(action: {
                homeData.isNewData.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        AngularGradient(gradient: .init(colors: [.red, .orange]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}
