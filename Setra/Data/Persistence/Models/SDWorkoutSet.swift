import Foundation
import SwiftData

@Model
final class SDWorkoutSet {
    @Attribute(.unique)
    var id: UUID
    
    var weight: Double
    var reps: Int
    var isCompleted: Bool
    
    init(id: UUID, weight: Double, reps: Int, isCompleted: Bool) {
        self.id = id
        self.weight = weight
        self.reps = reps
        self.isCompleted = isCompleted
    }
}
