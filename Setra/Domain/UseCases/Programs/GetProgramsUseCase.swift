import Foundation

protocol GetProgramsUseCase {
    func execute() async throws -> [WorkoutProgram]
}

final class DefaultGetProgramsUseCase: GetProgramsUseCase {
    private let repository: ProgramRepositories
    
    init(repository: ProgramRepositories) {
        self.repository = repository
    }
    
    func execute() async throws -> [WorkoutProgram] {
        try await repository.fetchPrograms()
    }
}
