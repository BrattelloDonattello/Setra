
import Foundation

struct ProgramExercises: Identifiable, Hashable {
    let id: UUID
    let exercises: Exercise
    var order: Int
    
    init(id: UUID = UUID(), exercises: Exercise, order: Int) {
        self.id = id
        self.exercises = exercises
        self.order = order
    }
}
