//
//  CodeView.swift
//  Algorithms
//
//  Created by Даниил Храповицкий on 14.08.2020.
//

import SwiftUI

enum WordType {
    case system  // розовый, жирный
    case varName  // синий
    case structName // голубой
    case text  // белый
    case systemFunc  // фиолетовый
    case systemStruct  // светло-фиолетовый
    case string  // оранжевый
}

struct CodeView: View {
    @State var code: String
    
    var body: some View {
        List {
            HStack {
                Image(systemName: "chevron.left.slash.chevron.right")
                    
                Text("Код")
            }
            .padding(8)
            .foregroundColor(.white)
                    
            Text(code)
                .padding(8)
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        CodeView(code: preview)
            .preferredColorScheme(.dark)
    }
}

let preview = """
public struct Stack<T> {
    fileprivate var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func push(_ element: T) {
        array.append(element)
    }

    public mutating func pop() -> T? {
        return array.popLast()
    }

    public var top: T? {
        return array.last
    }
}
"""
