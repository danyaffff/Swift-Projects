//
//  NewDataView.swift
//  Tasks App
//
//  Created by Даниил Храповицкий on 28.09.2020.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            HStack {
                Text("\(homeData.updateItem == nil ? "Add New" : "Update") Task")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            TextEditor(text: $homeData.content)
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            HStack(spacing: 10) {
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Tomorrow", homeData: homeData)
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            Button(action: {
                homeData.writeData(context: context)
            }, label: {
                Label(
                    title: {
                        Text(homeData.updateItem == nil ? "Add Now" : "Update")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    },
                    icon: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        LinearGradient(gradient: .init(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            .disabled(homeData.content == "")
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}
