import Foundation

protocol GetLastPerfomanceUseCase {
    func execute(exerciseID: UUID) async throws -> WorkoutExercise?
}

final class DefaultGetLastPerfomanceUseCase: GetLastPerfomanceUseCase{
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func execute(exerciseID: UUID) async throws -> WorkoutExercise? {
        try await repository.lastPerfomance(exerciseID: exerciseID)
    }
}
