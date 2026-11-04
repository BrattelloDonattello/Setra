import Foundation

struct WorkoutSession: Identifiable, Hashable {
    let id: UUID
    let programID: UUID?
    let programName: String
    let startedAt: Date
    var finishedAt: Date?
    var exercises: [WorkoutExercise]
    
    init(
        id: UUID = UUID(),
        programID: UUID?,
        programName: String,
        startedAt: Date = .now,
        finishedAt: Date? = nil,
        exercises: [WorkoutExercise]
    ) {
        self.id = id
        self.programID = programID
        self.programName = programName
        self.startedAt = startedAt
        self.finishedAt = finishedAt
        self.exercises = exercises
    }
}
