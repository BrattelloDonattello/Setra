import Foundation
import SwiftData

@Model
final class SDWorkoutExercise {
    @Attribute(.unique)
    var id: UUID
    
    var exerciseID: UUID
    var exerciseName: String
    
    var order: Int = 0
    
    @Relationship(deleteRule: .cascade)
    var sets: [SDWorkoutSet]
    
    init(
        id: UUID,
        exerciseID: UUID,
        exerciseName: String,
        order: Int = 0,
        sets: [SDWorkoutSet]
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.order = order
        self.sets = sets
    }
}
