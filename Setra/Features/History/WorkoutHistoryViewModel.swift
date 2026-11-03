
import Foundation
import Observation

@MainActor
@Observable
final class WorkoutHistoryViewModel {
    private(set) var workouts: [WorkoutSession] = []
    
    private(set) var isLoading = false
    
    var errorMessage: String?
    
    private let getWorkoutHistoryUseCase: GetWorkoutHistoryUseCase
    
    init(getWorkoutHistoryUseCase: GetWorkoutHistoryUseCase) {
        self.getWorkoutHistoryUseCase = getWorkoutHistoryUseCase
    }
    
    func load() async {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            workouts = try await getWorkoutHistoryUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func formattedDuration(_ workout: WorkoutSession) -> String {
        let totalMinutes = Int(workout.duration) / 60
        
        if totalMinutes < 60 {
            return "\(totalMinutes) min"
        }
        
        let hours = totalMinutes / 60
        
        let minutes = totalMinutes % 60
        
        return "\(hours)h \(minutes)min"
    }
    
    func formattedDate(_ date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }
        
        return date.formatted(.dateTime.day().month(.abbreviated))
    }
}
