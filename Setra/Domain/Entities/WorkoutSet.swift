import Foundation

struct WorkoutSet: Identifiable, Hashable {
    let id: UUID
    
    var order: Int
    
    var weight: Double
    var reps: Int
    var isCompleted: Bool
    
    init(
        id: UUID = UUID(),
        order: Int = 0,
        weight: Double = 0,
        reps: Int = 0,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.order = order
        self.weight = weight
        self.reps = reps
        self.isCompleted = isCompleted
    }
}
