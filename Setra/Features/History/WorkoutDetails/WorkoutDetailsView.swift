import SwiftUI

struct WorkoutDetailsView: View {
    
    @State private var viewModel: WorkoutDetailsViewModel
    
    init(viewModel: WorkoutDetailsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let workout = viewModel.workout {
                workoutContent(workout)
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(
                    "Unable to Load Workout",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else {
                ContentUnavailableView(
                    "Workout Not Found",
                    systemImage: "dumbbell",
                    description: Text(
                        "This workout could not be found."
                    )
                )
            }
        }
        .navigationTitle("Workout Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load()
        }
    }
    
    private func workoutContent(_ workout: WorkoutSession) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                workoutHeader(workout)
                
                workoutStatistics(workout)
                
                exercisesSection(workout)
            }
            .padding(16)
        }
    }
    
    private func workoutHeader(_ workout: WorkoutSession) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workout.programName)
                .font(.largeTitle.bold())
            
            Text(viewModel.formattedDate)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func workoutStatistics(_ workout: WorkoutSession) -> some View {
        HStack(spacing: 12) {
            statisticCard(
                title: "Duration",
                value: viewModel.formattedDuration,
                icon: "clock"
            )
            
            statisticCard(
                title: "Exercises",
                value: "\(workout.exercisesCount)",
                icon: "dumbbell"
            )
            
            statisticCard(
                title: "Sets",
                value: "\(workout.completedSetsCount)",
                icon: "checkmark.circle"
            )
        }
    }
    
    private func statisticCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.green)
            
            Text(value)
                .font(.headline)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func exercisesSection(_ workout: WorkoutSession) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Exercises")
                .font(.title2.bold())
            
            ForEach(workout.exercises.sorted {
                $0.order < $1.order
            }) { exercise in
                exerciseCard(exercise)
            }
        }
    }
    
    private func exerciseCard(_ exercise: WorkoutExercise) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(exercise.exerciseName)
                .font(.headline)
            
            Divider()
            
            ForEach(
                Array(exercise.sets.sorted{
                    $0.order < $1.order
                }.enumerated()), id: \.element.id
            ) { index, set in
                workoutSetRow(set, number: index + 1)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    private func workoutSetRow(_ set: WorkoutSet, number: Int) -> some View {
        HStack {
            Text("\(number)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 30)
            
            Text("\(set.weight.formatted()) kg x \(set.reps)")
                .font(.subheadline)
            
            Spacer()
            
            Image(systemName:  set.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(set.isCompleted ? .green : .secondary)
        }
        .padding(.vertical, 4)
    }
}
