import Foundation
import SwiftData

final class SwiftDataContainer {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for:
                                            SDWorkoutProgram.self,
                                           SDProgramExercise.self,
                                           SDWorkoutSession.self,
                                           SDWorkoutExercise.self,
                                           SDWorkoutSet.self
            )
        } catch {
            fatalError("Failed to create ModelContainter: \(error)")
        }
    }
}
