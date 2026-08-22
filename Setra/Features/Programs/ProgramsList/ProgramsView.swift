
import SwiftUI

struct ProgramsView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    var body: some View {
        VStack {
            ContentUnavailableView(
                "No Prgorams",
                systemImage: "dumbbell",
                description: Text("Create your first workout program.")
            )
        }
        .navigationTitle("Programs")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.navigate(to: .createProgram)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ProgramsView()
            .environment(AppCoordinator())
    }
}
