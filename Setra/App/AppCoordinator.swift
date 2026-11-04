
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class AppCoordinator {
    var selectedTab: AppTab = .home
    
    var createProgramViewModel: CreateProgramViewModel?
    
    var activeWorkout: WorkoutSession?
    
    var path = NavigationPath()
    
    var historyPath = NavigationPath()
    
    func startCreateProgram(viewModel: CreateProgramViewModel) {
        createProgramViewModel = viewModel
        
        path.append(AppRoute.createProgram)
    }
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else {return}
        
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func finishCreateProgram() {
        createProgramViewModel = nil
        
        popToRoot()
    }
    
    func startWorkout(_ workout: WorkoutSession) {
        activeWorkout = workout
        
        path.append(AppRoute.activeWorkout)
    }
    
    func finishWorkoutFlow() {
        activeWorkout = nil
        
        path = NavigationPath()
        
        selectedTab = .history
    }
    
    func openWorkoutDetails(id: UUID) {
        historyPath.append(AppRoute.workoutDetails(id))
    }
}
