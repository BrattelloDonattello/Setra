import Foundation
import Observation

@MainActor
@Observable
final class WorkoutDetailsViewModel {
    // MARK: - State
    
    private(set) var workout: WorkoutSession?
    
    private(set) var isLoading = false
    
    var errorMessage: String?
    
    var formattedDuration: String {
        guard let workout else {
            return "0 min"
        }
        
        let totalMinutes = Int(workout.duration) / 60
        
        if totalMinutes < 60 {
            return "\(totalMinutes) min"
        }
        
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        return "\(hours)h \(minutes)min"
    }
    
    var formattedDate: String {
        guard let workout else {
            return ""
        }
        
        return workout.startedAt.formatted(
            date: .abbreviated, time: .shortened
        )
    }
    
    // MARK: - Dependencies
    
    private let workoutID: UUID
    
    private let getWorkoutDetailsUseCase: GetWorkoutDetailsUseCase
    
    // MARK: - Init
    
    init(workoutID: UUID, getWorkoutDetailsUseCase: GetWorkoutDetailsUseCase) {
        self.workoutID = workoutID
        self.getWorkoutDetailsUseCase = getWorkoutDetailsUseCase
    }
    
    // MARK: - Methods
    
    func load() async {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            workout = try await getWorkoutDetailsUseCase.execute(id: workoutID)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
