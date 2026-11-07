import Foundation

struct WorkoutExercise: Identifiable, Hashable {
    let id: UUID
    let exerciseID: UUID
    let exerciseName: String
    
    var order: Int
    
    var sets: [WorkoutSet]
    
    init(
        id: UUID = UUID(),
        exerciseID: UUID,
        exerciseName: String,
        order: Int = 0,
        sets: [WorkoutSet] = []
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.order = order
        self.sets = sets
    }
}
