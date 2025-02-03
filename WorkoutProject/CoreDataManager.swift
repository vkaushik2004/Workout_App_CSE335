import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    @MainActor
    static let preview: CoreDataManager = {
        let result = CoreDataManager()
        let viewContext = result.persistentContainer.viewContext
//        for _ in 0..<10 {
//            let newItem = (context: viewContext)
//            newItem.timestamp = Date()
//        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    private init() {
//        persistentContainer = NSPersistentContainer(name: "WorkoutApp")
        persistentContainer = NSPersistentContainer(name: "DataModel")

        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Core Data failed: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    

//    func save() {
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save Core Data: \(error.localizedDescription)")
//        }
//    }
}
