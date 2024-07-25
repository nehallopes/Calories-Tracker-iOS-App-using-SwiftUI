//
//  HomeScreen.swift
//  HW3
//
//  Created by CDMStudent on 5/19/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @Binding var Calories_Intake: Double
    @Binding var Calories_Burned: Double
    @Binding var M_Logs: [Meal]
    @Binding var W_Logs: [Workout]
    
    @State private var CaloriesGoal: Double = 2000
    @State private var isSliderEnabled: Bool = false
    
    var body: some View {
        let Progress = Calories_Intake - Calories_Burned
        
        VStack(spacing: 20) {
            Text("My Kcal")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.top)
            
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("Calories Intake")
                        .font(.headline)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10.0)
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(Calories_Intake / CaloriesGoal, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.blue)
                            .rotationEffect(Angle(degrees: -90))
                        
                        Text("\(Int(Calories_Intake))")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(width: 150, height: 150)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 5)
                
                VStack(spacing: 8) {
                    Text("Calories Burned")
                        .font(.headline)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10.0)
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(Calories_Burned / CaloriesGoal, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.blue)
                            .rotationEffect(Angle(degrees: -90))
                        
                        Text("\(Int(Calories_Burned))")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(width: 150, height: 150)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            
            VStack {
                Toggle("Update Goal", isOn: $isSliderEnabled)
                    .padding(.horizontal)
                
                Slider(value: $CaloriesGoal, in: 1000...4000, step: 50)
                    .padding(.horizontal)
                    .disabled(!isSliderEnabled)
                
                Text("Calories Goal: \(Int(CaloriesGoal))")
                    .font(.headline)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
            
            VStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10.0)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(Progress / CaloriesGoal, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.green)
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text("\(Int(min(Progress / CaloriesGoal, 1.0) * 100))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(width: 175, height: 175)
                
                Text("Total Calories")
                    .font(.headline)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(Calories_Intake: .constant(1500), Calories_Burned: .constant(500), M_Logs: .constant([]), W_Logs: .constant([]))
    }
}
