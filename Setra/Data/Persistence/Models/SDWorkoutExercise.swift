import Foundation
import SwiftData

@Model
final class SDWorkoutExercise {
    @Attribute(.unique)
    var id: UUID
    
    var exerciseID: UUID
    var exerciseName: String
    
    @Relationship(deleteRule: .cascade)
    var sets: [SDWorkoutSet]
    
    init(id: UUID, exerciseID: UUID, exerciseName: String, sets: [SDWorkoutSet]) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.sets = sets
    }
}
