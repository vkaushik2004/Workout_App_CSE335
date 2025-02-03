//
//  WorkoutDetailView.swift
//  WorkoutProject
//
//  Created by Ashwini Kumar on 11/30/24.
//
import SwiftUI
import CoreData
import Charts


struct WorkoutDetailView: View {
    var workout: Workout
    @State private var exercises: [String] = [] // holds exxercises

    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.title ?? "Untitled Workout")
                .font(.largeTitle)
                .padding(.bottom)

            Text("Date: \(workout.date ?? Date(), style: .date)")
                .font(.headline)
                .padding(.bottom)

            Text("Location: \(workout.location ?? "No location specified")")
                .font(.subheadline)
                .padding(.bottom)

            Text("Exercises:")
                .font(.headline)
                .padding(.bottom)

            if exercises.isEmpty {
                Text("No exercises found.")
                    .foregroundColor(.red)
                    .padding(.bottom)
            } else {
                List {
                    ForEach(exercises, id: \.self) { exercise in
                        Text(exercise)
                            .font(.body)
                            .padding(.vertical, 2)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Workout Details")
        .onAppear {
            loadExercises()
        }
    }

    private func loadExercises() {
        // decode to string 
        if let exercisesString = workout.exercises as? String {
            self.exercises = exercisesString.components(separatedBy: ", ")
        }
    }
}
