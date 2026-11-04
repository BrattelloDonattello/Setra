
import Foundation

extension WorkoutSession {
    var duration: TimeInterval {
        guard let finishedAt else {
            return 0
        }
        
        return finishedAt.timeIntervalSince(startedAt)
    }
    
    var completedSetsCount: Int {
        exercises.reduce(0) { result, exercise in
            result + exercise.sets.filter{$0.isCompleted}.count
        }
    }
    
    var totalSetsCount: Int {
        exercises.reduce(0) {$0 + $1.sets.count}
    }
    
    var exercisesCount: Int {
        exercises.count
    }
}
