//
//  WorkoutScreen.swift
//  HW3
//
//  Created by CDMStudent on 5/19/24.
//

import SwiftUI

struct WorkoutScreen: View {
    
    @Binding var W_Logs: [Workout]
    @Binding var Calories_Burned: Double
    
    @State private var Selected_Workout: Int = 0
    @State private var Duration: Double = 0
    @State private var CaloriesBurned: String = ""
    @State private var Show_Alert: Bool = false
    @State private var Success_Alert: Bool = false
    
    let W_Types = ["Walking", "Running", "Swimming", "Cycling", "Yoga", "Weight Training", "HIIT", "Dancing", "Zumba", "Gymnastic"]
    
    var body: some View {
        VStack {
            Form {
                Picker("Select Workout", selection: $Selected_Workout) {
                    ForEach(0..<W_Types.count, id: \.self) { index in
                        Text(W_Types[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                Stepper(value: $Duration, in: 0...180, step: 5) {
                    Text("Duration: \(Int(Duration)) minutes")
                }
                
                TextField("Enter Calories Burned", text: $CaloriesBurned)
                    .keyboardType(.numberPad)
                
                Section(header: Text("Workout Logs")) {
                    if W_Logs.isEmpty {
                        Text("No workouts logged yet.")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(W_Logs) { workout in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(workout.name): \(Int(workout.caloriesBurned)) calories burned")
                                        Text("Duration: \(Int(workout.duration)) minutes")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Button(action: {
                                        DeleteWorkout(workout)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .onDelete(perform: DeleteAt)
                        }
                    }
                }
            }
            
            Button(action: {
                if Duration <= 0 || (Double(CaloriesBurned) ?? 0) <= 0 {
                    Show_Alert = true
                } else {
                    AddWorkout()
                }
            }) {
                Text("Add Workout")
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
            Alert(title: Text("Success"), message: Text("Workout added successfully"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Track Workout Kcal")
    }
    
    private func AddWorkout() {
        if let calories = Double(CaloriesBurned) {
            let Selected_Workout = W_Types[Selected_Workout]
            W_Logs.append(Workout(name: Selected_Workout, duration: Duration, caloriesBurned: calories))
            Calories_Burned += calories
            Duration = 0
            CaloriesBurned = ""
            Success_Alert = true
        }
    }
    
    private func DeleteWorkout(_ workout: Workout) {
        if let index = W_Logs.firstIndex(where: { $0.id == workout.id }) {
            Calories_Burned -= W_Logs[index].caloriesBurned
            W_Logs.remove(at: index)
        }
    }
    
    private func DeleteAt(offsets: IndexSet) {
        W_Logs.remove(atOffsets: offsets)
    }
}

struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen(W_Logs: .constant([]), Calories_Burned: .constant(0))
    }
}

struct Workout: Identifiable {
    var id = UUID()
    var name: String
    var duration: Double
    var caloriesBurned: Double
}
