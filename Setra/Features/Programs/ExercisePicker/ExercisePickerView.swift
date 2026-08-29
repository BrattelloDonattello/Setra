
import SwiftUI

struct ExercisePickerView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    var body: some View {
        if let viewModel = coordinator.createProgramViewModel {
            content(viewModel: viewModel)
        } else {
            ContentUnavailableView("Something went wrong", systemImage: "exclamationmark.triangle")
        }
    }
    
    private func content(viewModel: CreateProgramViewModel) -> some View {
        List {
            ForEach(ExerciseCatalog.exercises) { exercises in
                ExercisePickerRow(
                    exercises: exercises,
                    isSelected: viewModel.isSelected(exercises)) {
                        viewModel.toggleExercise(exercises)
                    }
            }
        }
        .navigationTitle("Exercises")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            
        }
    }
    
    private func doneButton(viewModel: CreateProgramViewModel) -> View {
        Button {
            coordinator.pop()
        } label: {
            Text("Done (\(viewModel.selectedExercises.count))")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

#Preview {
    NavigationView {
        ExercisePickerView()
            .environment(AppCoordinator())
    }
}
