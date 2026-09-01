
import Foundation
import SwiftData

@Model
final class SDProgramExercise {
    @Attribute(.unique)
    var id: UUID
    
    var exerciseID: UUID
    
    var exerciseName: String
    
    var muscleGroupRawValue: String
    
    var order: Int
    
    init(id: UUID, exerciseID: UUID, exerciseName: String, muscleGroupRawValue: String, order: Int) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.muscleGroupRawValue = muscleGroupRawValue
        self.order = order
    }
}
