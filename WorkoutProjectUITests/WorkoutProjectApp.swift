////
////  WorkoutProjectApp.swift
////  WorkoutProject
////
////  Created by Ashwini Kumar on 11/30/24.
////
//
//import SwiftUI
//import CoreData
//import SwiftData
//
//
//@main
//struct WorkoutProjectApp: App {
////    var sharedModelContainer: ModelContainer = {
////        let schema = Schema([
////            Item.self,
////        ])
////        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
////
////        do {
////            return try ModelContainer(for: schema, configurations: [modelConfiguration])
////        } catch {
////            fatalError("Could not create ModelContainer: \(error)")
////        }
////    }()
//
//    var body: some Scene {
//        WindowGroup {
//            WeeklyView()
//        }
//    }
//}


import SwiftUI

@main
struct testApp: App {
    let persistenceController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}
