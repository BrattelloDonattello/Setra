import SwiftUI

struct ActiveWorkoutView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    @State private var viewModel: ActiveWorkoutViewModel
    
    init(viewModel: ActiveWorkoutViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                timerSection
                
                ForEach(viewModel.workout.exercises) { exercise in
                    workoutExerciseCard(exercise)
                }
                
                finishButton
            }
            .padding()
        }
        .navigationTitle(viewModel.workout.programName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func workoutExerciseCard(_ exercise: WorkoutExercise) -> some View {
        VStack(alignment: .leading, spacing: 17) {
            Text(exercise.exerciseName)
                .font(.title3.bold())
            
            setHeader
            
            ForEach(Array(exercise.sets.enumerated()), id: \.element.id) { index, workoutSet in
                WorkoutSetRow(
                    setNumber: index + 1,
                    workotuSet: workoutSet,
                    onWeightChanged: { weight in
                        viewModel.updateWeight(exerciseID: exercise.id, setID: workoutSet.id, weight: weight)
                    },
                    onRepsChanged: { reps in
                        viewModel.updateReps(exerciseID: exercise.id, setID: workoutSet.id, reps: reps)
                    },
                    onComplete: {
                        viewModel.toggleSetCompletion(exerciseID: exercise.id, setID: workoutSet.id)
                    }
                )
            }
            
            Button {
                viewModel.addSet(exerciseID: exercise.id)
            } label: {
                Label("Add Set", systemImage: "plus.circle")
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    private var timerSection: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            Text(viewModel.formattedElapsedTime(currentDate: context.date))
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .monospacedDigit()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
        }
    }
    
    private var setHeader: some View {
        HStack {
            Text("SET")
                .frame(width: 35)
            Spacer()
            
            Text("KG")
                .frame(width: 80)
            
            Text("REPS")
                .frame(width: 80)
            
            Text("")
                .frame(width: 40)
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
    
    private var finishButton: some View {
        Button {
            Task {
                let success = await viewModel.finish()
                
                if success {
                    coordinator.popToRoot()
                }
            }
        } label: {
            if viewModel.isFinishing {
                ProgressView()
                    .tint(.black)
            } else {
                Text("Finish Workout")
                    .font(.headline)
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
