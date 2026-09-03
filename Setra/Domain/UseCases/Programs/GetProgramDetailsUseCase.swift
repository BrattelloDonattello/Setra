import Foundation

protocol GetProgramDetailsUseCase {
    func execute(id: UUID) async throws -> WorkoutProgram?
}

final class DefaultGetProgramDetailsUseCase: GetProgramDetailsUseCase {
    private let repository: ProgramRepositories
    
    init(repository: ProgramRepositories) {
        self.repository = repository
    }
    
    func execute(id: UUID) async throws -> WorkoutProgram? {
        try await repository.fetchProgram(id: id)
    }
}
