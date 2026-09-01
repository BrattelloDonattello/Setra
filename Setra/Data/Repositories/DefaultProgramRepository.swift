
import Foundation
import SwiftData

@MainActor
final class DefaultProgramRepository: ProgramRepositories {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchPrograms() async throws -> [WorkoutProgram] {
        let description = FetchDescriptor<SDWorkoutProgram>(sortBy: [SortDescriptor(\.createdAT, order: .reverse)])
        
        let models = try modelContext.fetch(description)
        
        return models.map{$0.toDomain()}
    }
    
    func fetchProgram(id: UUID) async throws -> WorkoutProgram? {
        let programID = id
        
        let description = FetchDescriptor<SDWorkoutProgram>(predicate: #Predicate{ model in
            model.id == programID
        })
        
        let model = try modelContext.fetch(description).first
        
        return model?.toDomain()
    }
    
    func save(_ program: WorkoutProgram) async throws {
        let programID = program.id
        
        let descriptor = FetchDescriptor<SDWorkoutProgram>(predicate: #Predicate{ model in
            model.id == programID
        })
        
        if let existingModel = try modelContext.fetch(descriptor).first {
            existingModel.update(from: program)
        } else {
            let model = SDWorkoutProgram.fromDomain(program)
            
            modelContext.insert(model)
        }
    }
    
    func delete(id: UUID) async throws {
        let programID = id
        
        let descriptor = FetchDescriptor<SDWorkoutProgram>(predicate: #Predicate{ model in
            model.id == programID
        })
        
        guard let model = try modelContext.fetch(descriptor).first else { return }
        
        modelContext.delete(model)
        
        try modelContext.save()
    }
}
