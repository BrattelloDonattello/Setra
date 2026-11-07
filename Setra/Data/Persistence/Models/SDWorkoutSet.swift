import Foundation
import SwiftData

@Model
final class SDWorkoutSet {
    @Attribute(.unique)
    var id: UUID
    
    var order: Int = 0
    
    var weight: Double
    var reps: Int
    var isCompleted: Bool
    
    init(
        id: UUID,
        order: Int = 0,
        weight: Double,
        reps: Int,
        isCompleted: Bool
    ) {
        self.id = id
        self.order = order
        self.weight = weight
        self.reps = reps
        self.isCompleted = isCompleted
    }
}
