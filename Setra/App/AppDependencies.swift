import Foundation
import SwiftData

@MainActor
final class AppDependencies {
    private let swiftDataContainer: SwiftDataContainer
    
    private let programRepository: ProgramRepositories
    
    private let workoutRepository: WorkoutRepository
    
    init() {
        swiftDataContainer = SwiftDataContainer()
        
        programRepository = DefaultProgramRepository(modelContext: swiftDataContainer.container.mainContext)
        
        workoutRepository = InMemoryWorkoutRepository()
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
    
    func makeGetProgramDetailsUseCase() -> GetProgramDetailsUseCase {
        DefaultGetProgramDetailsUseCase(repository: programRepository)
    }
    
    func makeProgramDetailsViewModel(programID: UUID) -> ProgramDetailsViewModel {
        ProgramDetailsViewModel(programID: programID, getProgramDetailsUseCase: makeGetProgramDetailsUseCase())
    }
    
    func makeStartWorkoutUseCase() -> StartWorkoutUseCase {
        DefaultStartWorkoutUseCase()
    }
    
    func makeFinishWorkoutUseCase() -> FinishWorkoutUseCase {
        DefaultFinishWorkoutUseCase(repository: workoutRepository)
    }
}
