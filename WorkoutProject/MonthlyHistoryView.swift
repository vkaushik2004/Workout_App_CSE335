//
//  MonthlyHistoryView.swift
//  WorkoutProject
//
//  Created by Ashwini Kumar on 11/30/24.

import Charts
import SwiftUI
import CoreData


struct MonthlyHistoryView: View {
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)]
    ) var completedWorkouts: FetchedResults<Workout>

    var body: some View {
//        let workoutDates = completedWorkouts.compactMap { $0.date }
//        let workouts: [(String, Date)] = completedWorkouts.compactMap { ($0.title ?? "") as String? ; ($0.date ?? (Date.now)) as Date?}
        CalendarView(completedWorkouts: completedWorkouts)
    }
}



struct CalendarView: View {
    var completedWorkouts: FetchedResults<Workout>
    @State private var selectedWorkout: Workout? // To track the selected workout
    @State private var isDetailViewPresented = false // To track whether the detail view is shown

    var body: some View {
        VStack {
            Text("Monthly View")
                .font(.largeTitle)
                .padding()

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(completedWorkouts, id: \.self) { workout in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(workout.title ?? "Untitled Workout")
                                    .font(.headline)
                                Text(workout.date ?? Date(), style: .date)
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                selectedWorkout = workout
                                isDetailViewPresented = true
                            }) {
                                Text("Details")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $isDetailViewPresented) {
            if let selectedWorkout = selectedWorkout {
                WorkoutDetailView(workout: selectedWorkout)
            }
        }
    }
}
