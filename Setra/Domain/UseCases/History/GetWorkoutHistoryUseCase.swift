import Foundation

protocol GetWorkoutHistoryUseCase {
    func execute() async throws -> [WorkoutSession]
}

final class DefaultGetWorkoutHistoryUseCase: GetWorkoutHistoryUseCase {
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [WorkoutSession] {
        try await repository.fetchHistory()
    }
}
