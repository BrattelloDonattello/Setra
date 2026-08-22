
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class AppCoordinator {
    var selectedTab: AppTab = .home
    
    var path = NavigationPath()
    
    var presentWorkoutID: UUID?
    
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
    
    func startWorkout(id: UUID) {
        presentWorkoutID = id
    }
    
    func dismissWorkout() {
        presentWorkoutID = nil
    }
}
