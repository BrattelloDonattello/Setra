import SwiftUI

struct ProgramDetailsView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    @State private var viewModel: ProgramDetailsViewModel
    
    init(viewModel: ProgramDetailsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let program = viewModel.program {
                content(program: program)
            } else {
                ContentUnavailableView("Program not found", systemImage: "exclamationmark.triangle")
            }
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
    
    private func content(program: WorkoutProgram) -> some View {
        List {
            Section {
                ForEach(program.exercise.sorted{ $0.order < $1.order }) { programExercise in
                    exerciseRow(programExercise)
                }
            } header: {
                Text("\(program.exercise.count) Exercises")
            }
        }
        .navigationTitle(program.name)
        .safeAreaInset(edge: .bottom) {
            startWorkoutButton
        }
    }
    
    private func exerciseRow(_ programExercise: ProgramExercises) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(programExercise.exercises.name)
                .font(.headline)
            
            Text(programExercise.exercises.muscleGroup.title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private var startWorkoutButton: some View {
        Button {
            Task {
                guard let workout = await viewModel.startWorkout() else {
                    return
                }
                
                coordinator.startWorkout(workout)
            }
        } label: {
            Text("Start Workout")
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
