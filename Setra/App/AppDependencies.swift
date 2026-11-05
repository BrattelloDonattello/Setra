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
        
        workoutRepository = DefaultWorkoutRepository(modelContext: swiftDataContainer.container.mainContext)
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
        ProgramDetailsViewModel(programID: programID, getProgramDetailsUseCase: makeGetProgramDetailsUseCase(), startWorkoutUseCase: makeStartWorkoutUseCase())
    }
    
    func makeStartWorkoutUseCase() -> StartWorkoutUseCase {
        DefaultStartWorkoutUseCase()
    }
    
    func makeFinishWorkoutUseCase() -> FinishWorkoutUseCase {
        DefaultFinishWorkoutUseCase(repository: workoutRepository)
    }
    
    func makeActiveWorkoutViewModel(workout: WorkoutSession) -> ActiveWorkoutViewModel {
        ActiveWorkoutViewModel(workout: workout, finishWorkoutUseCase: makeFinishWorkoutUseCase(), getLastPerfomanceUseCase: makeGetLastPerfomanceUseCase())
    }
    
    func makeGetWorkoutHistoryUseCase() -> GetWorkoutHistoryUseCase {
        DefaultGetWorkoutHistoryUseCase(repository: workoutRepository)
    }
    
    func makeWorkoutHistoryViewModel() -> WorkoutHistoryViewModel {
        WorkoutHistoryViewModel(getWorkoutHistoryUseCase:makeGetWorkoutHistoryUseCase())
    }
    
    func makeGetWorkoutDetailsUseCase() -> GetWorkoutDetailsUseCase {
        DefaultGetWorkoutDetailsUseCase(repository: workoutRepository)
    }
    
    func makeWorkoutDetailsViewModel(workoutID: UUID) -> WorkoutDetailsViewModel {
        WorkoutDetailsViewModel(workoutID: workoutID, getWorkoutDetailsUseCase: makeGetWorkoutDetailsUseCase())
    }
    
    func makeGetLastPerfomanceUseCase() -> GetLastPerfomanceUseCase {
        DefaultGetLastPerfomanceUseCase(repository: workoutRepository)
    }
}
