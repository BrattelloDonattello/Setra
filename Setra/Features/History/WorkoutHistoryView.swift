
import SwiftUI

struct WorkoutHistoryView: View {
    @State private var viewModel: WorkoutHistoryViewModel
    
    init(viewModel: WorkoutHistoryViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.workouts.isEmpty {
                ProgressView()
            } else if viewModel.workouts.isEmpty {
                emptyState
            } else {
                workoutList
            }
        }
        .navigationTitle("History")
        .task {
            await viewModel.load()
        }
        .refreshable {
            await viewModel.load()
        } 
        .alert(
            "Something went wrong",
            isPresented:
                Binding(
                    get: {
                        viewModel.errorMessage != nil
                    },
                    set: { newValue in

                        if !newValue {
                            viewModel.errorMessage = nil
                        }
                    }
                )
        ) {
            Button(
                "OK",
                role: .cancel
            ) {}
        } message: {
            Text(
                viewModel.errorMessage ?? ""
            )
        }
    }
    
    private var emptyState: some View {
        ContentUnavailableView(
            "No Workouts Yet",
            systemImage:
                "clock.arrow.circlepath",
            description: Text("Completed workouts will appear here.")
        )
    }
    
    private var workoutList: some View {
        List(viewModel.workouts) { workout in
            workoutRow(workout)
        }
        .listStyle(.plain)
    }
    
    private func workoutRow(_ workout: WorkoutSession) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(workout.programName)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            
            Text(viewModel.formattedDate(workout.startedAt))
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            HStack(spacing: 16) {
                Label(viewModel.formattedDuration(workout), systemImage: "clock")
                
                Label("\(workout.exercisesCount)", systemImage: "dumbbell")
                
                Label("\(workout.completedSetsCount)", systemImage: "checkmark.circle")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
    
}

//#Preview {
//    WorkoutHistoryView()
//}
