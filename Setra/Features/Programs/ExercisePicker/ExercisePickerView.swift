
import SwiftUI

struct ExercisePickerView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    @State private var selectedExercises: Set<String> = []
    
    private let exercises = [
        "Bench Press",
        "Incline Bench Press",
        "Chest Fly",
        "Shoulder Press",
        "Lateral Raise",
        "Lat Pulldown",
        "Seated Row",
        "Biceps Curl",
        "Triceps Pushdown",
        "Squat"
    ]
    
    var body: some View {
        List(exercises, id: \.self) { exercise in
            ExercisePickerRow(title: exercise, isSelected: selectedExercises.contains(exercise)) {
                toggle(exercise)
            }
        }
        .navigationTitle("Exercises")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            doneButton
        }
    }
    
    
    private var doneButton: some View {
        Button {
            coordinator.pop()
        } label: {
            Text(
                "Done (\(selectedExercises.count))"
            )
            .font(.headline)
            .foregroundStyle(.black)
            .frame(
                maxWidth: .infinity
            )
            .frame(
                height: 54
            )
            .background(
                Color.green
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 16
                )
            )
        }
        .disabled(
            selectedExercises.isEmpty
        )
        .padding()
        .background(
            .ultraThinMaterial
        )
    }
    
    
    private func toggle(
        _ exercise: String
    ) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }
}

#Preview {
    NavigationView {
        ExercisePickerView()
            .environment(AppCoordinator())
    }
}
