//
//  ContentView.swift
//  Activity
//
//  Created by Даниил Храповицкий on 25.07.2020.
//

import SwiftUI
import HealthKit

let filler: [DataType] = [
    DataType(data: 40, date: Date(timeIntervalSinceNow: -6 * 24 * 60 * 60)),
    DataType(data: 120, date: Date(timeIntervalSinceNow: -5 * 24 * 60 * 60)),
    DataType(data: 580, date: Date(timeIntervalSinceNow: -4 * 24 * 60 * 60)),
    DataType(data: 180, date: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60)),
    DataType(data: 850, date: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60)),
    DataType(data: 90, date: Date(timeIntervalSinceNow: -1 * 24 * 60 * 60)),
    DataType(data: 50, date: Date())
]

struct ContentView: View {
    @State var steps: [DataType] = [DataType]()
    @State var burnedEnergies: [DataType] = [DataType]()
    @State var waters: [DataType] = [DataType]()
    @State var consumedEnergies: [DataType] = [DataType]()
    @State var height: Double = Double() // метры
    @State var mass: Int = Int()
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
        
        UITableView.appearance().sectionHeaderHeight = .zero
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    CellView(type: String.Activity.step, data: $steps, mass: $mass)
                }
                
                Section {
                    CellView(type: String.Activity.burnedEnergy, data: $burnedEnergies, mass: $mass)
                }
                
                Section {
                    CellView(type: String.Activity.water, data: $waters, mass: $mass)
                }
                
                Section {
                    CellView(type: String.Activity.consumedEnergy, data: $consumedEnergies, mass: $mass)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Активность")
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("Данные")
            }))
            .onAppear {
                if let healthStore = healthStore {
                    healthStore.requestAutorization { success in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateStepsFromStatistics(statisticsCollection)
                                }
                            }
                            
                            healthStore.calculateBurnedEnergy { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateBurnedEnergyFromStatistics(statisticsCollection)
                                }
                            }
                            
                            healthStore.calculateWater { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateWaterFromStatistics(statisticsCollection)
                                }
                            }
                            
                            healthStore.calculateConsumedEnergy { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateConsumedEnergyFromStatistics(statisticsCollection)
                                }
                            }
                            
//                            healthStore.calculateHeight { statisticsCollection in
//                                if let statisticsCollection = statisticsCollection {
//                                    updateHeightFromStatistics(statisticsCollection)
//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateStepsFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, to: Date()) { statistics, stop in
            let countSteps = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = DataType(data: Int(countSteps ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    private func updateBurnedEnergyFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, to: Date()) { statistics, stop in
            let countBurnedEnergy = statistics.sumQuantity()?.doubleValue(for: .kilocalorie())
            
            let burnedEnergy = DataType(data: Int(countBurnedEnergy ?? 0), date: statistics.startDate)
            burnedEnergies.append(burnedEnergy)
        }
    }
    
    private func updateWaterFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, to: Date()) { statistics, stop in
            let countWater = statistics.sumQuantity()?.doubleValue(for: .literUnit(with: .milli))
            
            let water = DataType(data: Int(countWater ?? 0), date: statistics.startDate)
            waters.append(water)
        }
    }
    
    private func updateConsumedEnergyFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, to: Date()) { statistics, stop in
            let countConsumedEnergy = statistics.sumQuantity()?.doubleValue(for: .kilocalorie())
            
            let consumedEnergy = DataType(data: Int(countConsumedEnergy ?? 0), date: statistics.startDate)
            consumedEnergies.append(consumedEnergy)
        }
    }
    
//    private func updateHeightFromStatistics(_ statisticsCollection: HKSample) {
//        let countHeight = statisticsCollection.
//
//        let height = Double(countHeight ?? 0)
//        self.height = height
//    }
    
    private func updateMassFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: Date(), to: Date()) { statistics, stop in
            let countMass = statistics.sumQuantity()?.doubleValue(for: .gramUnit(with: .kilo))
            
            let mass = Int(countMass ?? 0)
            self.mass = mass
        }
    }
}

struct CellView: View {
    @Environment(\.colorScheme) private var colorScheme
    var type: ActivityType
    
    @Binding var data: [DataType]
    @Binding var mass: Int
    
    @State private var isPresentedAddView = false
    @State private var isPresentedSummaryView = false
    
    private var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "cccccc"
        return formatter
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: type.image)
            
            Text(type.name)
                .fontWeight(.semibold)
        }
        .font(.subheadline)
        .foregroundColor(type.color)
        
        Button(action: {
            isPresentedSummaryView.toggle()
        }, label: {
            HStack(alignment: .lastTextBaseline) {
                ForEach(data, id: \.id) { day in
                    Spacer()
                    
                    VStack {
                        Text(String(format: "%d", day.data!))
                            .foregroundColor(colorScheme == .light ? .black : .white)
                        
                        TopRoundedRectangle()
                            .fill(type.color)
                            .frame(width: 25, height: getHeight(for: CGFloat(day.data!), max: getMax(in: data)))
                        
                        Text(weekdayFormatter.string(from: day.date))
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    .font(.caption)
                    
                    Spacer()
                }
            }
        })
        .sheet(isPresented: $isPresentedSummaryView) {
            SummaryView(data: $data, mass: $mass, type: type)
        }
        
        Button(action: {
            isPresentedAddView.toggle()
        }, label: {
            Text("Добавить данные")
        })
        .sheet(isPresented: $isPresentedAddView) {
            AddView(type: type)
        }
    }
    
    func getHeight(for value: CGFloat, max: CGFloat) -> CGFloat {
        if max > 0 {
            return value / max * 100 + 5
        } else {
            return 5
        }
    }
    
    func getMax(in week: [DataType]) -> CGFloat {
        var max = 0
        
        for day in week {
            if day.data ?? 0 > max {
                max = day.data!
            }
        }
        
        return CGFloat(max)
    }
}

struct AddView: View {
    @Environment(\.presentationMode) private var presentation
    @Environment(\.colorScheme) private var colorScheme
    
    @State var addedData = ""
    @State private var isDatePicker = false
    @State var selected = 0
    
    var type: ActivityType
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    isDatePicker = true
                }, label: {
                    HStack {
                        Text("Дата")
                            
                        Spacer()
                            
                        PickerField(data: formattedString(), selectionIndex: $selected)
                    }
                })
                .foregroundColor(colorScheme == .light ? .black : .white)
                
                Button(action: {
                    isDatePicker = false
                }, label: {
                    HStack {
                        Text(type.measure)
                        
                        Spacer()
                        
                        TextField("", text: $addedData)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                })
                .foregroundColor(colorScheme == .light ? .black : .white)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(type.name, displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Отменить")
                }), trailing: Button(action: {
                    // Тут ввод новых данных
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Добавить")
                })
                .disabled(addedData == ""))
        }
    }
    
    func formattedString() -> [String] {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "cccccc, dd MMMM"
            return formatter
        }
        
        let dates: [String] = [
            "Сегодня",
            "Вчера",
            dateFormatter.string(from: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60)),
            dateFormatter.string(from: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60)),
            dateFormatter.string(from: Date(timeIntervalSinceNow: -4 * 24 * 60 * 60)),
            dateFormatter.string(from: Date(timeIntervalSinceNow: -5 * 24 * 60 * 60)),
            dateFormatter.string(from: Date(timeIntervalSinceNow: -6 * 24 * 60 * 60)),
        ]
        
        return dates
    }
}

class PickerTextField: UITextField {
    @Binding var selectionIndex: Int
    
    var data: [String]

    init(data: [String], selectionIndex: Binding<Int>) {
        self.data = data
        self._selectionIndex = selectionIndex
        super.init(frame: .zero)

        self.inputView = pickerView
        self.tintColor = .clear
    }

    @available(macOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Ты зачем это вызвал блинб? 😡😡😡😡😡")
    }

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    @objc
    private func donePressed() {
        self.selectionIndex = self.pickerView.selectedRow(inComponent: 0)
        self.endEditing(true)
    }
}

struct PickerField: UIViewRepresentable {
    @Binding var selectionIndex: Int

    private var data: [String]
    private let textField: PickerTextField
    
    init(data: [String], selectionIndex: Binding<Int>) {
        self.data = data
        self._selectionIndex = selectionIndex

        textField = PickerTextField(data: data, selectionIndex: selectionIndex)
    }

    func makeUIView(context: UIViewRepresentableContext<PickerField>) -> UITextField {
        textField.textAlignment = .right
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<PickerField>) {
        uiView.text = data[selectionIndex]
    }
}

struct SummaryView: View {
    @Environment(\.presentationMode) private var presentation
    
    @Binding var data: [DataType]
    @Binding var mass: Int
    
    @State var done: Int = 0
    @State var type: ActivityType
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text(type.name == "Шаги" ? "Стремитесь проходить около" : type.name == "Энергия активности" ? "" : type.name == "Вода" ? "Рекомендуемая суточная норма для Вас:" : "")
                            .fontWeight(.semibold)
                                
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("\(String(format: "%d", mass * 30))")
                                .foregroundColor(.blue)
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .fontWeight(.bold)
                                
                            Text("мл.")
                                .fontWeight(.semibold)
                        }
                        .padding(.bottom, 8)
                        .padding(.top, 4)
                            
                        Text("Из расчета 30 мл на кг массы тела.")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 10)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Сегодня Вы выпили:")
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("\(String(format: "%d", getData()))")
                                .foregroundColor(.blue)
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .fontWeight(.bold)
                            
                            Text("мл.")
                                .fontWeight(.semibold)
                        }
                        .padding(.top, 4)
                        
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(UIColor.systemGray5))
                                .frame(height: 30)
                            
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                                    .frame(width: getWidth(for: CGFloat(done), windowSize: geometry.size.width), height: 30)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("\(type.name)", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentation.wrappedValue.dismiss()
            }, label: {
                Text("Готово")
            }))
        }
    }
    
    func getData() -> Int {
        if type.name == "Шаги" {
            return data[0].data!
        } else if type.name == "Энергия активности" {
            return data[1].data!
        } else if type.name == "Вода" {
            return data[2].data!
        } else {
            return data[3].data!
        }
    }
    
    func getWidth(for data: CGFloat, windowSize size: CGFloat) -> CGFloat {
        let value = data * size / (CGFloat(mass) * 30)
        
        if data == 0 {
            return 0
        } else if data < CGFloat(mass) * 30 {
            return value
        } else {
            return size
        }
    }
}

struct TopRoundedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class HealthStore {
    var healthStore: HKHealthStore?
    
    var stepQuery: HKStatisticsCollectionQuery?
    var burnedEnergyQuery: HKStatisticsCollectionQuery?
    var waterQuery: HKStatisticsCollectionQuery?
    var consumedEnergyQuery: HKStatisticsCollectionQuery?
    var heightQuery: HKSampleQuery?
    var massQuery: HKStatisticsCollectionQuery?
    
    let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .day, value: -6, to: Date()), end: Date(), options: .strictStartDate)
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        stepQuery = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: Date.monday12AM(), intervalComponents: DateComponents(day: 1))
        stepQuery!.initialResultsHandler = { stepQuery, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let stepQuery = stepQuery {
            healthStore.execute(stepQuery)
        }
    }
        
    func calculateBurnedEnergy(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let burnedEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
            
        burnedEnergyQuery = HKStatisticsCollectionQuery(quantityType: burnedEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: Date.monday12AM(), intervalComponents: DateComponents(day: 1))
        
        burnedEnergyQuery!.initialResultsHandler = { burnedEnergyQuery, statisticsCollection, error in
            completion(statisticsCollection)
        }
            
        if let healthStore = healthStore, let burnedEnergyQuery = burnedEnergyQuery {
            healthStore.execute(burnedEnergyQuery)
        }
    }
        
    func calculateWater(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
            
        waterQuery = HKStatisticsCollectionQuery(quantityType: waterType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: Date.monday12AM(), intervalComponents: DateComponents(day: 1))
        
        waterQuery!.initialResultsHandler = { waterQuery, statisticsCollection, error in
            completion(statisticsCollection)
        }
            
        if let healthStore = healthStore, let waterQuery = waterQuery {
            healthStore.execute(waterQuery)
        }
    }
        
    func calculateConsumedEnergy(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let consumedEnergyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
            
        consumedEnergyQuery = HKStatisticsCollectionQuery(quantityType: consumedEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: Date.monday12AM(), intervalComponents: DateComponents(day: 1))
        
        consumedEnergyQuery!.initialResultsHandler = { consumedEnergyQuery, statisticsCollection, error in
            completion(statisticsCollection)
        }
            
        if let healthStore = healthStore, let consumedEnergyQuery = consumedEnergyQuery {
            healthStore.execute(consumedEnergyQuery)
        }
    }
    
    func calculateHeight(completion: @escaping (HKSample?) -> Void) {
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        
        heightQuery = HKSampleQuery(sampleType: heightType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { heightQuery, statisticsCollection, error in
            completion(statisticsCollection![statisticsCollection!.count - 1])
        }
        
        if let healthStore = healthStore, let heightQuery = heightQuery {
            healthStore.execute(heightQuery)
        }
    }
    
    func calculateMass(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let massType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        
        massQuery = HKStatisticsCollectionQuery(quantityType: massType, quantitySamplePredicate: predicate, options: .mostRecent, anchorDate: Date.monday12AM(), intervalComponents: DateComponents(day: 1))
        massQuery!.initialResultsHandler = { massQuery, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let massQuery = massQuery {
            healthStore.execute(massQuery)
        }
    }
    
    func requestAutorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let burnedEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        let consumedEnergyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let massType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        
        guard let healthStore = healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [stepType, burnedEnergyType, waterType, consumedEnergyType], read: [stepType, burnedEnergyType, waterType, consumedEnergyType, heightType, massType]) { success, _ in
            completion(success)
        }
    }
}

struct DataType: Identifiable {
    var id = UUID()
    var data: Int?
    var date: Date
}

struct ActivityType {
    var name: String
    var measure: String
    var image: String
    var color: Color
}

extension String {
    struct Activity {
        static var step: ActivityType { return ActivityType(name: "Шаги", measure: "Шаги", image: "flame.fill", color: .red) }
        static var burnedEnergy: ActivityType { return ActivityType(name: "Энергия активности", measure: "ккал", image: "flame.fill", color: .red) }
        static var water: ActivityType { return ActivityType(name: "Вода", measure: "мл", image: "drop.fill", color: .blue) }
        static var consumedEnergy: ActivityType { return ActivityType(name: "Энергетическая ценность", measure: "ккал", image: "leaf.fill", color: .green) }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Date {
    static func monday12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

extension PickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectionIndex = row
    }
}
