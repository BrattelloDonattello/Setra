
import Foundation
import Observation

@MainActor
@Observable
final class CreateProgramViewModel {
    var name = ""
    
    private(set) var selectedExercises: [Exercise] = []
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !selectedExercises.isEmpty
    }
    
    func toggleExercise(_ exercise: Exercise) {
        if isSelected(exercise) {
            selectedExercises.removeAll{
                $0.id == exercise.id
            }
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    func isSelected(_ exercise: Exercise) -> Bool {
        selectedExercises.contains { $0.id == exercise.id }
    }
    
    func removeExercise(_ exercise: Exercise) {
        selectedExercises.removeAll { $0.id == exercise.id }
    }
}
