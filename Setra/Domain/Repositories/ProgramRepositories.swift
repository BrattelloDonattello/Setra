
import Foundation

protocol ProgramRepositories {
    func fetchPrograms() async throws -> [WorkoutProgram]
    
    func fetchProgram(id: UUID) async throws -> WorkoutProgram?
    
    func save(_ program: WorkoutProgram) async throws
    
    func delete(id: UUID) async throws
}
