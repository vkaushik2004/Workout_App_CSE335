import SwiftUI
import CoreData

struct CreateWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchQuery = ""
    @State private var searchResults: [[String: String]] = []  // array of dictionaries that store json data
    @State private var addedExercises: [String] = []  // exercise names
    @State private var workoutTitle = ""
    @State private var selectedLocation = ""
    @State private var workoutDay = Date()
    private var exerciseAPI = ExerciseAPI()

    var body: some View {
        VStack {
            TextField("Workout Title", text: $workoutTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Search Exercises", text: $searchQuery, onCommit: fetchExercises)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if !searchResults.isEmpty {
                List(searchResults, id: \.self) { exercise in
                    Button(action: {
                        addExercise(exercise)
                    }) {
                        VStack(alignment: .leading) {
                            Text(exercise["name"] ?? "Unknown Exercise").bold()
                            Text(exercise["muscle"] ?? "Unknown Muscle").font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
            //pick date workout was completed
            DatePicker(selection: $workoutDay, in: ...Date.now, displayedComponents: .date) {
                Text("Select a date")}

            Text("Added Exercises:")
                .font(.headline)
                .padding(.top)

            List(addedExercises, id: \.self) { exercise in
                Text(exercise)
            }
            .frame(maxHeight: 200)

            NavigationLink(destination: MapView()) {
                Text("See Current Location")
            }
            .padding()

            if !selectedLocation.isEmpty {
                Text("Selected Location: \(selectedLocation)")
                    .font(.subheadline)
                    .padding()
            }

            Button("Save Workout") {
                saveWorkout()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Create Workout")
    }

    //fetch using api key from file
    private func fetchExercises() {
        guard !searchQuery.isEmpty else { return }

        // Call the ExerciseAPI to fetch exercises based on muscle group
        exerciseAPI.fetchExercises(for: searchQuery) { exercises in
            if let exercises = exercises {
                DispatchQueue.main.async {
                    searchResults = exercises
                }
            } else {
                print("No exercises found or error fetching data.")
            }
        }
    }

    //add exercise
    private func addExercise(_ exercise: [String: String]) {
        if let exerciseName = exercise["name"], !addedExercises.contains(exerciseName) {
            addedExercises.append(exerciseName)
        }
    }

    //save workout and keep persistent
    private func saveWorkout() {
        let newWorkout = Workout(context: viewContext)
        newWorkout.title = workoutTitle
        newWorkout.date = workoutDay
        newWorkout.location = selectedLocation
        
        // Save the added exercises as a comma-separated string in Core Data
        let exercisesString = addedExercises.joined(separator: ", ")
        newWorkout.exercises = exercisesString as NSObject
        
        do {
            try viewContext.save()
            print("Workout saved!")
        } catch {
            print("Failed to save workout: \(error)")
        }
    }
}
