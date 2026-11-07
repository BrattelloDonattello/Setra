import Foundation
import Observation

@MainActor
@Observable
final class ActiveWorkoutViewModel {
    private(set) var workout: WorkoutSession
    private(set) var previousPerformance: [UUID: WorkoutExercise] = [:]
    private(set) var isFinishing = false
    var errorMessage: String?
    
    private let finishWorkoutUseCase: FinishWorkoutUseCase
    private let getLastPerfomanceUseCase: GetLastPerfomanceUseCase
    
    var elapsedTime: TimeInterval {
        Date().timeIntervalSince(workout.startedAt)
    }
    
    init(
        workout: WorkoutSession,
        finishWorkoutUseCase: FinishWorkoutUseCase,
        getLastPerfomanceUseCase: GetLastPerfomanceUseCase
    ) {
        self.workout = workout
        self.finishWorkoutUseCase = finishWorkoutUseCase
        self.getLastPerfomanceUseCase = getLastPerfomanceUseCase
    }
    
    func updateWeight(exerciseID: UUID, setID: UUID, weight: Double) {
        guard let exerciseIndex = workout.exercises.firstIndex(where: {$0.id == exerciseID}) else {
            return
        }
        
        guard let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: {$0.id == setID}) else {
            return
        }
        
        workout.exercises[exerciseIndex].sets[setIndex].weight = weight
    }
    
    func updateReps(exerciseID: UUID, setID: UUID, reps: Int) {
        guard let exerciseIndex = workout.exercises.firstIndex(where: {$0.id == exerciseID}) else {
            return
        }
        
        guard let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: {$0.id == setID}) else {
            return
        }
        
        workout.exercises[exerciseIndex].sets[setIndex].reps = reps
    }
    
    func toggleSetCompletion(exerciseID: UUID, setID: UUID) {
        guard let exerciseIndex = workout.exercises.firstIndex(where: {$0.id == exerciseID}) else {
            return
        }
        
        guard let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: {$0.id == setID}) else {
            return
        }
        
        workout.exercises[exerciseIndex].sets[setIndex].isCompleted.toggle()
    }
    
    
    func addSet(
        exerciseID: UUID
    ) {
        guard let exercisIndex = workout.exercises.firstIndex(
            where: {$0.id == exerciseID}
        ) else {
            return
        }
        
        let sets = workout.exercises[exercisIndex].sets
        
        let previousSet = sets.last
        
        let nextOrder = (sets.map(\.order).max() ?? -1) + 1
        
        let newSet = WorkoutSet(
            order: nextOrder,
            weight: previousSet?.weight ?? 0,
            reps:  previousSet?.reps ?? 0
        )
        
        workout.exercises[exercisIndex]
            .sets
            .append(newSet)
    }
    
    func removeSet(exerciseID: UUID, setID: UUID) {
        guard let exerciseIndex = workout.exercises.firstIndex(where: {$0.id == exerciseID}) else {
            return
        }
        
        guard let setIndex = workout.exercises[exerciseIndex].sets.firstIndex(where: {$0.id == setID}) else {
            return
        }
        
        workout.exercises[exerciseIndex].sets.removeAll(where: {$0.id == setID})
    }
    
    func finish() async -> Bool {
        guard !isFinishing else {
            return false
        }
        
        isFinishing = true
        
        defer {
            isFinishing = false
        }
        
        do {
            
            workout = try await finishWorkoutUseCase.execute(workout: workout)
            
            return true
        } catch {
            errorMessage = error.localizedDescription
            
            return false
        }
    }
    
    func formattedElapsedTime(currentDate: Date) -> String {
        let interval = currentDate.timeIntervalSince(workout.startedAt)
        
        let totalSeconds = Int(interval)
        
        let hourse = totalSeconds / 3600
        
        let minutes = (totalSeconds % 3600) / 60
        
        let seconds = totalSeconds % 60
        
        if hourse > 0 {
            return String(format: "%02d:%02d:%02d", hourse, minutes, seconds)
        }
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func loadPreviousPerfomance() async {
        for exercise in workout.exercises {
            
            do {
                let previous = try await getLastPerfomanceUseCase.execute(exerciseID: exercise.exerciseID)
                
                if let previous {
                    previousPerformance[exercise.exerciseID] = previous
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            
        }
    }
    
    func previousSet(
        exerciseID: UUID,
        setIndex: Int
    ) -> WorkoutSet? {
        guard let exercise = previousPerformance[
            exerciseID
        ] else {
            return nil
        }
        
        let sortedSets = exercise.sets
            .sorted {
                $0.order < $1.order
            }
        
        guard sortedSets.indices.contains(setIndex) else {
            return nil
        }
        
        return sortedSets[setIndex]
    }
}
