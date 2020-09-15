//
//  ContentView.swift
//  Analog Clock
//
//  Created by Даниил Храповицкий on 14.09.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Clock()
    }
}

struct Clock: View {
    private let width = UIScreen.main.bounds.width
    @State private var currentTime = Time(millisecond: 0, second: 0, minute: 0, hour: 0)
    @State private var reciever = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(UIColor.systemGray5))
                    .frame(width: width / 1.2, height: width / 1.2)
                
                ForEach(1 ... 12, id: \.self) { number in
                    let angle = CGFloat(number) * CGFloat.pi / 6 - CGFloat.pi / 2
                    
                    let sinus = sin(angle) * width / 2.9
                    
                    let cosinus = cos(angle)  * width / 2.9

                    Text("\(number)")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: cosinus, y: sinus)
                }
                
                Hour()
                    .rotationEffect(.degrees((Double(currentTime.minute) / 60 + Double(currentTime.hour)) * 30))
                
                Minute()
                    .rotationEffect(.degrees((Double(currentTime.second) / 60 + Double(currentTime.minute)) * 6))
                
                Second()
                    .rotationEffect(.degrees((Double(currentTime.millisecond) / 100 + Double(currentTime.second)) * 6))
            }
        }
        .onAppear() {
            let calendar = Calendar.current
            
            let millisecond = Double(calendar.component(.nanosecond, from: Date())) / 10e6
            let second = calendar.component(.second, from: Date())
            let minute = calendar.component(.minute, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(.linear(duration: 0.01)) {
                currentTime = Time(millisecond: Int(millisecond), second: second, minute: minute, hour: hour)
            }
        }
        .onReceive(reciever) { (_) in
            let calendar = Calendar.current
            
            let millisecond = Double(calendar.component(.nanosecond, from: Date())) / 10e6
            let second = calendar.component(.second, from: Date())
            let minute = calendar.component(.minute, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(.linear(duration: 0.01)) {
                currentTime = Time(millisecond: Int(millisecond), second: second, minute: minute, hour: hour)
            }
        }
    }
}

struct Hour: View {
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 2, height: width / 23)
            .offset(y: -width / 27)

        
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 8, height: width / 5)
            .offset(y: -width / 6.5)
    }
}

struct Minute: View {
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .frame(width: width / 35, height: width / 35)
        
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 2, height: width / 23)
            .offset(y: -width / 27)

        
        RoundedRectangle(cornerRadius: 4)
            .stroke(lineWidth: 2)
            .frame(width: 6, height: width / 3.5)
            .offset(y: -width / 5)
    }
}

struct Second: View {
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Color.red)
            .frame(width: 2, height: width / 2.2)
            .offset(y: -width / 6.5)
        
        Circle()
            .fill(Color.red)
            .frame(width: width / 50, height: width / 50)
    }
}

struct Time {
    var millisecond: Int
    var second: Int
    var minute: Int
    var hour: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
