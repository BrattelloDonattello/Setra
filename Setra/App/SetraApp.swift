
import SwiftUI

@main
struct SetraApp: App {
    private let dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(dependencies: dependencies)
        }
    }
}
