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

extension WorkoutSession {
    var duration: TimeInterval {
        guard let finishedAt else {
            return 0
        }
        
        return finishedAt.timeIntervalSince(startedAt)
    }
    
    var completedSetsCount: Int {
        exercises.reduce(0) { result, exercise in
            result + exercise.sets.filter{$0.isCompleted}.count
        }
    }
    
    var totalSetsCount: Int {
        exercises.reduce(0) {$0 + $1.sets.count}
    }
    
    var exercisesCount: Int {
        exercises.count
    }
}
