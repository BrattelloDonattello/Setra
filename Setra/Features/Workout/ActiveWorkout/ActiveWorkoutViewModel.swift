import Foundation
import Observation

@MainActor
@Observable
final class ActiveWorkoutViewModel {
    private(set) var workout: WorkoutSession
    private(set) var isFinishing = false
    var errorMessage: String?
    
    private let finishWorkoutUseCase: FinishWorkoutUseCase
    
    var elapsedTime: TimeInterval {
        Date().timeIntervalSince(workout.startedAt)
    }
    
    init(workout: WorkoutSession, finishWorkoutUseCase: FinishWorkoutUseCase) {
        self.workout = workout
        self.finishWorkoutUseCase = finishWorkoutUseCase
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
    
    func addSet(exerciseID: UUID) {
        guard let exerciseIndex = workout.exercises.firstIndex(where: {$0.id == exerciseID}) else {
            return
        }
        
        let previousSet = workout.exercises[exerciseIndex].sets.last
        
        let newSet = WorkoutSet(weight: previousSet?.weight ?? 0, reps: previousSet?.reps ?? 0)
        
        workout.exercises[exerciseIndex].sets.append(newSet)
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
            try await finishWorkoutUseCase.execute(workout: workout)
            
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
}
