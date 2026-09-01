import Foundation
import SwiftData

@MainActor
final class AppDependencies {
    private let swiftDataContainer: SwiftDataContainer
    
    private let programRepository: ProgramRepositories
    
    init() {
        swiftDataContainer = SwiftDataContainer()
        
        programRepository = DefaultProgramRepository(modelContext: swiftDataContainer.container.mainContext)
    }
    
    func makeCreateProgramUseCase() -> CreateProgramUseCase {
        DefaultCreateProgramUseCase(repository: programRepository)
    }
    
    func makeGetProgramsUseCase() -> GetProgramsUseCase {
        DefaultGetProgramsUseCase(repository: programRepository)
    }
    
    func makeProgramsListViewModel() -> ProgramsListViewModel {
        ProgramsListViewModel(getProgramsUseCase: makeGetProgramsUseCase())
    }
    
    func makeCreateProgramViewModel() -> CreateProgramViewModel {
        CreateProgramViewModel(createProgramUseCase: makeCreateProgramUseCase())
    }
}
