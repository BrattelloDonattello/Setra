
import Foundation

struct WorkoutProgram: Identifiable, Hashable {
    let id: UUID
    let name: String
    let exercise: [ProgramExercises]
    
    init(id: UUID = UUID(), name: String, exercise: [ProgramExercises]) {
        self.id = id
        self.name = name
        self.exercise = exercise
    }
}
