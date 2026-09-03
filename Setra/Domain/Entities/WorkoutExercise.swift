import Foundation

struct WorkoutExercise: Identifiable, Hashable {
    let id: UUID
    let exerciseID: UUID
    let exerciseName: String
    var sets: [WorkoutSet]
    
    init(
        id: UUID = UUID(),
        exerciseID: UUID,
        exerciseName: String,
        sets: [WorkoutSet] = []
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.sets = sets
    }
}
