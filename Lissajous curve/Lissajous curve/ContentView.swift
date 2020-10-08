//
//  ContentView.swift
//  Lissajous curve
//
//  Created by Даниил Храповицкий on 08.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var selection: [Int] = [0, 0]
    
    private let minBottomViewHeight = UIScreen.main.bounds.height / 9
    private let maxBottomViewHeight = UIScreen.main.bounds.height / 2.5
    
    private let settings: [[String]] = [
        Array(1 ... 5).map{ "\($0)" },
        Array(1 ... 5).map{ "\($0)" },
    ]
    
    private var timer = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    private var radius: CGFloat = UIScreen.main.bounds.width / 4
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .offset(y: -UIScreen.main.bounds.height / 2)
                .offset(x: radius * sin(CGFloat(selection[0] + 1) * CGFloat.pi * progress / 180), y: -radius * cos(CGFloat(selection[1] + 1) * CGFloat.pi * progress / 180))
            
                ZStack {
                    BlurView()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .offset(y: maxBottomViewHeight - minBottomViewHeight)
                        .offset(y: offset)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.001))
                        .gesture(DragGesture().onChanged({ (value) in
                            withAnimation{
                                if value.startLocation.y > maxBottomViewHeight / 2 {
                                    offset = value.translation.height
                                }
                                
                                if value.startLocation.y < maxBottomViewHeight / 2 {
                                    if value.translation.height > 0 && offset < 0 {
                                        offset = value.translation.height + minBottomViewHeight - maxBottomViewHeight
                                    }
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation {
                                if value.startLocation.y > maxBottomViewHeight / 2 {
                                    if -value.translation.height > maxBottomViewHeight / 2 {
                                        offset = minBottomViewHeight - maxBottomViewHeight
                                        
                                        return
                                    }
                                    
                                    offset = 0
                                }
                                
                                if value.startLocation.y < maxBottomViewHeight / 2 {
                                    if value.translation.height < maxBottomViewHeight / 2 {
                                        offset =  minBottomViewHeight - maxBottomViewHeight
                                        
                                        return
                                    }
                                    
                                    offset = 0
                                }
                            }
                        }))
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 6)
                            .padding(.vertical, 10)
                        
                        HStack {
                            Text("Настройки")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 0) {
                                PickerView(data: settings, selections: $selection)
                            }
                        }
                    }
                    .padding(.bottom, 60)
                    .cornerRadius(16)
                    .offset(y: maxBottomViewHeight - minBottomViewHeight)
                    .offset(y: offset)
                }
                .frame(height: maxBottomViewHeight, alignment: .bottom)
            }
        .frame(height: UIScreen.main.bounds.height, alignment: .bottom)
        .preferredColorScheme(.dark)
        .onReceive(timer) { (_) in
            withAnimation(.linear(duration: 0.01)) {
                progress += 1
                
                if progress > 360 {
                    withAnimation(.linear(duration: 0.01)) {
                        progress = 0
                    }
                }
            }
        }
    }
}
struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PickerView: UIViewRepresentable {
    var data: [[String]]
    @Binding var selections: [Int]
    
    func makeCoordinator() -> PickerView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<PickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<PickerView>) {
        for i in 0...(self.selections.count - 1) {
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: PickerView
        
        init(_ pickerView: PickerView) {
            self.parent = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component] = row
        }
    }
}
