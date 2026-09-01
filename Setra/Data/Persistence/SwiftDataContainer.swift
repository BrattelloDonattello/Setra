import Foundation
import SwiftData

final class SwiftDataContainer {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: SDWorkoutProgram.self, SDWorkoutProgram.self)
        } catch {
            fatalError("Failed to create ModelContainter: \(error)")
        }
    }
}
