import Foundation
import Observation

@MainActor
@Observable
final class ProgramsListViewModel {
    private(set) var programs: [WorkoutProgram] = []
    
    private(set) var isLoading = false
    
    var errorMessage: String?
    
    private let getProgramsUseCase: GetProgramsUseCase
    
    init(getProgramsUseCase: GetProgramsUseCase) {
        self.getProgramsUseCase = getProgramsUseCase
    }
    
    func loadPrograms() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            programs = try await getProgramsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
