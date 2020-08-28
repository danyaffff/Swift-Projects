//
//  ListCellView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

struct ListCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State var element: HomeListType
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(element.color)
                    .frame(width: 29, height: 29, alignment: .center)
                
                if element.isSystemImage {
                    Image(systemName: element.image)
                        .foregroundColor(.white)
                } else {
                    Text(element.image)
                        .foregroundColor(.white)
                }
            }
            
            
            Text(element.name)
                .foregroundColor(colorScheme == .light ? .black : .white)
        }
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellView(element: infoDataStructures[0])
    }
}
