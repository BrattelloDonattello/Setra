import Foundation
import SwiftData

@Model
final class SDWorkoutSession {
    @Attribute(.unique)
    var id: UUID
    
    var programID: UUID?
    var programName: String
    
    var startedAt: Date
    var finishAt: Date?
    
    @Relationship(deleteRule: .cascade)
    var exercises: [SDWorkoutExercise]
    
    init(id: UUID, programID: UUID? = nil, programName: String, startedAt: Date, finishAt: Date? = nil, exercises: [SDWorkoutExercise]) {
        self.id = id
        self.programID = programID
        self.programName = programName
        self.startedAt = startedAt
        self.finishAt = finishAt
        self.exercises = exercises
    }
}
