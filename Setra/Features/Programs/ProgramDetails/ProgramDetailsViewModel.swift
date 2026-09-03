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
    
    init(programID: UUID, getProgramDetailsUseCase: GetProgramDetailsUseCase) {
        self.programID = programID
        self.getProgramDetailsUseCase = getProgramDetailsUseCase
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
}
