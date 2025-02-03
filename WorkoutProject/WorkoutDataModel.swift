
import Foundation
import CoreData

// Exercise model for API and encoding/decoding
struct Exercise: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}

