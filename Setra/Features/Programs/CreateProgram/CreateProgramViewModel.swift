
import Foundation
import Observation

@MainActor
@Observable
final class CreateProgramViewModel {
    var name = ""
    
    private(set) var selectedExercises: [Exercise] = []
    
    private(set) var isSaving = false
    
    var errorMessage: String?
    
    private let createProgramUseCase: CreateProgramUseCase
    
    init(createProgramUseCase: CreateProgramUseCase) {
        self.createProgramUseCase = createProgramUseCase
    }
    
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
    
    func save() async -> Bool {
        guard canSave else {
            return false
        }
        
        isSaving = true
        
        defer {
            isSaving = false
        }
        
        do {
            try await createProgramUseCase.execute(name: name, exercises: selectedExercises)
            
            return true
        } catch {
            errorMessage = error.localizedDescription
            
            return false
        }
    }
}
