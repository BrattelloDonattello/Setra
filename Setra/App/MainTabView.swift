import SwiftUI

struct MainTabView: View {
    
    @Bindable var coordinator: AppCoordinator
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(
                    "Home",
                    systemImage: "house"
                )
            }
            .tag(AppTab.home)
            
            NavigationStack(path: $coordinator.path) {
                ProgramsView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .createProgram:
                            CreateProgramView()
                        case .exercisePicker:
                            ExercisePickerView()
                        }
                    }
            }
            .tabItem {
                Label(
                    "Programs",
                    systemImage: "list.bullet.rectangle"
                )
            }
            .tag(AppTab.programs)
            
            NavigationStack {
                HistoryView()
            }
            .tabItem {
                Label(
                    "History",
                    systemImage: "clock.arrow.circlepath"
                )
            }
            .tag(AppTab.history)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label(
                    "Settings",
                    systemImage: "gearshape"
                )
            }
            .tag(AppTab.settings)
        }
    }
}

#Preview {
    MainTabView(coordinator: AppCoordinator())
}
