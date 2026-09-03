
import Foundation

protocol CreateProgramUseCase {
    func execute(name: String, exercises: [Exercise]) async throws
}

final class DefaultCreateProgramUseCase: CreateProgramUseCase {
    
    private let repository: ProgramRepositories
    
    init(repository: ProgramRepositories) {
        self.repository = repository
    }
    
    func execute(name: String, exercises: [Exercise]) async throws {
        let trimedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimedName.isEmpty else {
            return
        }
        
        guard !exercises.isEmpty else {
            return
        }
        
        let programExercises = exercises.enumerated().map{ index, exercise in
                ProgramExercises(exercises: exercise, order: index)
        }
        
        let program = WorkoutProgram(name: trimedName, exercise: programExercises)
        
        try await repository.save(program)
    }
}
