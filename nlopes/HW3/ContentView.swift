//
//  ContentView.swift
//  HW3
//
//  Created by CDMStudent on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var Calories_Intake: Double = 0
    @State private var Calories_Burned: Double = 0
    @State private var M_Logs: [Meal] = []
    @State private var W_Logs: [Workout] = []
    
    var body: some View {
        TabView {
            NavigationView {
                HomeScreen(Calories_Intake: $Calories_Intake, Calories_Burned: $Calories_Burned, M_Logs: $M_Logs, W_Logs: $W_Logs)
                    .navigationTitle("Home")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationView {
                MealScreen(M_Logs: $M_Logs, Calories_Intake: $Calories_Intake)
                    .navigationTitle("Add Meal")
            }
            .tabItem {
                Image(systemName: "fork.knife")
                Text("Meal")
            }
            
            NavigationView {
                WorkoutScreen(W_Logs: $W_Logs, Calories_Burned: $Calories_Burned)
                    .navigationTitle("Add Workout")
            }
            .tabItem {
                Image(systemName: "figure.run")
                Text("Workout")
            }
        }
    }
}
