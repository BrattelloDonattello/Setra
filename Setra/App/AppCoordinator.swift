
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class AppCoordinator {
    var selectedTab: AppTab = .home
    
    var path = NavigationPath()
    
    var createProgramViewModel: CreateProgramViewModel?
    
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
}
