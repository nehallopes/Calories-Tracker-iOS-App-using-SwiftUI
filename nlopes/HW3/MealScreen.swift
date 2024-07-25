//
//  MealScreen.swift
//  HW3
//
//  Created by CDMStudent on 5/19/24.
//

import SwiftUI

struct MealScreen: View {
    
    @Binding var M_Logs: [Meal]
    @Binding var Calories_Intake: Double
    
    @State private var M_Name: String = ""
    @State private var Calories_Consumed: String = ""
    @State private var Show_Alert: Bool = false
    @State private var Success_Alert: Bool = false
    @State private var M_Type: MealType = .breakfast
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter Meal Name", text: $M_Name)
                
                TextField("Enter Calories Consumed", text: $Calories_Consumed)
                    .keyboardType(.numberPad)
                
                Picker("Meal Type", selection: $M_Type) {
                    ForEach(MealType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                
                Section(header: Text("Meal Logs")) {
                    if M_Logs.isEmpty {
                        Text("No meals logged yet.")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(M_Logs) { meal in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(meal.name): \(Int(meal.calories)) calories")
                                        Text("Type: \(meal.type.rawValue.capitalized)")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Button(action: {
                                        DeleteMeal(meal)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .onDelete(perform: DeleteAtIndex)
                        }
                    }
                }
            }
            
            Button(action: {
                if M_Name.isEmpty || (Double(Calories_Consumed) ?? 0) <= 0 {
                    Show_Alert = true
                } else {
                    AddMeal()
                }
            }) {
                Text("Add Meal")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .alert(isPresented: $Show_Alert) {
            Alert(title: Text("Error"), message: Text("Please fill in all fields correctly"), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $Success_Alert) {
            Alert(title: Text("Success"), message: Text("Meal added successfully"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Track Meal Kcal")
    }
    
    private func AddMeal() {
        if let calories = Double(Calories_Consumed) {
            M_Logs.append(Meal(name: M_Name, calories: calories, type: M_Type))
            Calories_Intake += calories
            M_Name = ""
            Calories_Consumed = ""
            Success_Alert = true
        }
    }
    
    private func DeleteMeal(_ meal: Meal) {
        if let index = M_Logs.firstIndex(where: { $0.id == meal.id }) {
            Calories_Intake -= M_Logs[index].calories
            M_Logs.remove(at: index)
        }
    }
    
    private func DeleteAtIndex(offsets: IndexSet) {
        M_Logs.remove(atOffsets: offsets)
    }
}

struct Meal: Identifiable {
    var id = UUID()
    var name: String
    var calories: Double
    var type: MealType
}

enum MealType: String, CaseIterable {
    case breakfast
    case lunch
    case snack
    case dinner
}
