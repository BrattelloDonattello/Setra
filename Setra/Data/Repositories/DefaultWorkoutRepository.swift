import Foundation
import SwiftData

@MainActor
final class DefaultWorkoutRepository: WorkoutRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(_ workout: WorkoutSession) async throws {
        let workoutID = workout.id
        
        let descriptor = FetchDescriptor<SDWorkoutSession>(predicate: #Predicate{ model in
            model.id == workoutID
        })
        
        if let existingModel = try modelContext.fetch(descriptor).first {
            existingModel.update(from: workout)
        } else {
            let model = SDWorkoutSession.fromDomain(workout)
            
            modelContext.insert(model)
        }
        
        try modelContext.save()
    }
    
    func fetchWorkout(id: UUID) async throws -> WorkoutSession? {
        let workoutID = id
        
        let descriptor = FetchDescriptor<SDWorkoutSession>(predicate: #Predicate { model in
            model.id == workoutID
        })
        
        return try modelContext.fetch(descriptor).first?.toDomain()
    }
    
    func fetchHistory() async throws -> [WorkoutSession] {
        let descriptor = FetchDescriptor<SDWorkoutSession>(sortBy: [
            SortDescriptor(\.startedAt, order: .reverse)
        ])
        
        return try modelContext.fetch(descriptor).map{
            $0.toDomain()
        }
    }
    
    func lastPerfomance(exerciseID: UUID) async throws -> WorkoutExercise? {
        let descriptor = FetchDescriptor<SDWorkoutSession>(sortBy: [
            SortDescriptor(\.startedAt, order: .reverse)
        ])
        
        let workouts = try modelContext.fetch(descriptor)
        
        for workout in workouts {
            guard workout.finishAt != nil else {
                continue
            }
            
            if let exercise = workout.exercises.first(where: {
                $0.exerciseID == exerciseID
            }) {
                return exercise.toDomain()
            }
        }
        
        return nil
    }
}
