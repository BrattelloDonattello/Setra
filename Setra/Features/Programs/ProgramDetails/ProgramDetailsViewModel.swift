import Foundation
import Observation

@MainActor
@Observable
final class ProgramDetailsViewModel {
    private(set) var program: WorkoutProgram?
    
    private(set) var isLoading = false
    
    var errorMessage: String?
    
    private let programID: UUID
    
    private let getProgramDetailsUseCase: GetProgramDetailsUseCase
    
    private let startWorkoutUseCase: StartWorkoutUseCase
    
    init(programID: UUID, getProgramDetailsUseCase: GetProgramDetailsUseCase, startWorkoutUseCase: StartWorkoutUseCase) {
        self.programID = programID
        self.getProgramDetailsUseCase = getProgramDetailsUseCase
        self.startWorkoutUseCase = startWorkoutUseCase
    }
    
    func load() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            program = try await getProgramDetailsUseCase.execute(id: programID)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func startWorkout() async -> WorkoutSession? {
        guard let program else {
            return nil
        }
        
        do {
            return try await startWorkoutUseCase.execute(program: program)
        } catch {
            errorMessage = error.localizedDescription
            
            return nil
        }
    }
}
