
import SwiftUI
//just the two nav links to the functionalities
struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: CreateWorkoutView()) {
                    Text("Create Workout")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                .padding(.horizontal)

                NavigationLink(destination: MonthlyHistoryView()) {
                    Text("Monthly View")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
            }
            .navigationTitle("Home")
        }
    }
}
