import Foundation

protocol WorkoutRepository {
    func save(_ workout: WorkoutSession) async throws
    
    func fetchWorkout(id: UUID) async throws -> WorkoutSession?
    
    func fetchHistory() async throws -> [WorkoutSession]
    
    func lastPerfomance(exerciseID: UUID) async throws -> WorkoutExercise?
}
