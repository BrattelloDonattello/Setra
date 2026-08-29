
import Foundation
import SwiftUI

struct AppCoordinatorView: View {
    @State private var coordinator = AppCoordinator()
    
    var body: some View {
        MainTabView(
            coordinator: coordinator
        )
        .environment(coordinator)
    }
}

#Preview {
    AppCoordinatorView()
}
