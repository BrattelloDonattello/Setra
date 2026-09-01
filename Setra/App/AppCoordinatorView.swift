
import Foundation
import SwiftUI

struct AppCoordinatorView: View {
    @State private var coordinator = AppCoordinator()
    
    let dependencies: AppDependencies
    
    var body: some View {
        MainTabView(
            coordinator: coordinator,
            dependencies: dependencies
        )
        .environment(coordinator)
    }
}
