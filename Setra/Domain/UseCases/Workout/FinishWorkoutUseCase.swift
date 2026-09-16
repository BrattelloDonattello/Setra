import Foundation

protocol FinishWorkoutUseCase {
    func execute(workout: WorkoutSession) async throws -> WorkoutSession
}

final class DefaultFinishWorkoutUseCase: FinishWorkoutUseCase {
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func execute(workout: WorkoutSession) async throws -> WorkoutSession {
        var finishedWorkout = workout
        
        finishedWorkout.finishedAt = Date()
        
        try await repository.save(finishedWorkout)
        
        return finishedWorkout
    }
}
