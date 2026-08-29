
import SwiftUI

struct ExercisePickerRow: View {
    let exercises: Exercise
    
    let isSelected: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercises.name)
                        .foregroundStyle(.primary)
                    
                    Text(exercises.muscleGroup.title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundStyle(isSelected ? .green : .secondary)
            }
        }
        .buttonStyle(.plain)
    }
}
