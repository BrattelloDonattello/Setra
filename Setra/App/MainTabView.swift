import SwiftUI

struct MainTabView: View {
    
    @Bindable var coordinator: AppCoordinator
    
    let dependencies: AppDependencies
    
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
                ProgramsView(viewModel: dependencies.makeProgramsListViewModel(), makeCreateProgramViewModel: { dependencies.makeCreateProgramViewModel() })
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .createProgram:
                            CreateProgramFlowView()
                        case .exercisePicker:
                            ExercisePickerView()
                        case .programDetails(let programID):
                            ProgramDetailsView(viewModel: dependencies.makeProgramDetailsViewModel(programID: programID))
                        case .activeWorkout:
                            if let workout = coordinator.activeWorkout {
                                ActiveWorkoutView(viewModel: dependencies.makeActiveWorkoutViewModel(workout: workout))
                            } else {
                                ContentUnavailableView("Workout not found", systemImage: "exclamationmark.triangle")
                            }
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
