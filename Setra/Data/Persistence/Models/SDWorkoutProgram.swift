
import Foundation
import SwiftData

@Model
final class SDWorkoutProgram {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var createdAT: Date
    
    @Relationship(deleteRule: .cascade)
    var exercises: [SDProgramExercise]
    
    init(id: UUID, name: String, createdAT: Date = .now, exercises: [SDProgramExercise] = []) {
        self.id = id
        self.name = name
        self.createdAT = createdAT
        self.exercises = exercises
    }
}
