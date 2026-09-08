
import SwiftUI

struct WorkoutSetRow: View {
    let setNumber: Int
    let workotuSet: WorkoutSet
    
    let onWeightChanged: (Double) -> Void
    
    let onRepsChanged: (Int) -> Void
    
    let onComplete: () -> Void
    
    @State private var weightText = ""
    
    @State private var repsText = ""
    
    var body: some View {
        HStack {
            Text("\(setNumber)")
                .frame(width: 35)
            
            Spacer()
            
            TextField("0", text: $weightText)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .frame(width: 80, height: 40)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onChange(of: weightText) { _, newValue in
                    let normalized = newValue.replacingOccurrences(of: ",", with: ".")
                    
                    guard let weight = Double(normalized) else {
                        return
                    }
                    
                    onWeightChanged(weight)
                }
            
            TextField("0", text: $repsText)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 80, height: 40)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onChange(of: repsText) { _, newValue in
                    guard let reps = Int(newValue) else {
                        return
                    }
                    
                    onRepsChanged(reps)
                }
            
            Button(action: onComplete) {
                Image(systemName: workotuSet.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(workotuSet.isCompleted ? .green : .secondary)
                    .frame(width: 40)
            }
        }
        .onAppear {
            if workotuSet.weight > 0 {
                weightText = String(workotuSet.weight)
            }
            
            if workotuSet.reps > 0 {
                repsText = String(workotuSet.reps)
            }
        }
    }
}
