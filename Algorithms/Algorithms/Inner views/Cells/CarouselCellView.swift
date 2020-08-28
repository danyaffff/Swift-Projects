//
//  CarouselCellView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 04.08.2020.
//

import SwiftUI

struct CarouselCellView: View {
    @State var element: HomeListType
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(element.color)
                
                Text(element.name)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .padding(.leading, 8)
            }
            .frame(width: 150, height: 100)
                
            if element.isSystemImage {
                Image(systemName: element.image)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
            } else {
                Text(element.image)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
            }
        }
        .padding(.vertical)
    }
}

struct CarouselCellView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCellView(element: carouselDataTypes[1])
    }
}
