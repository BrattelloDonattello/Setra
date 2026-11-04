import Foundation

protocol GetWorkoutDetailsUseCase {
    func execute(id: UUID) async throws -> WorkoutSession?
}

final class DefaultGetWorkoutDetailsUseCase: GetWorkoutDetailsUseCase {
    private var repository: WorkoutRepository
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) async throws -> WorkoutSession? {
        try await repository.fetchWorkout(id: id)
    }
}
