
import Foundation

final class InMemoryWorkoutRepository: WorkoutRepository {
    private var workouts: [WorkoutSession] = []
    
    func save(_ workout: WorkoutSession) async throws {
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
        } else {
            workouts.append(workout)
        }
    }
    
    func fetchWorkout(id: UUID) async throws -> WorkoutSession? {
        workouts.first{
            $0.id == id
        }
    }
    
    func fetchHistory() async throws -> [WorkoutSession] {
        workouts.sorted {
            $0.startedAt > $1.startedAt
        }
    }
    
    func lastPerfomance(exerciseID: UUID) async throws -> WorkoutExercise? {
        workouts.sorted {
            $0.startedAt > $1.startedAt
        }
        .compactMap { workout in
            workout.exercises.first {
                $0.exerciseID == exerciseID
            }
        }
        .first
    }
}
