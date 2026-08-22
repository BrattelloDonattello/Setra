import SwiftUI

struct CreateProgramView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    @State private var programName = ""
    
    var body: some View {
        Form {
            Section(
                "Program Name"
            ) {
                TextField("Push Day", text: $programName)
            }
            
            Section("Exercises") {
                Button {
                    coordinator.navigate(to: .exercisePicker)
                } label: {
                    Label("Add Exercises", systemImage: "plus.circle.fill")
                }
            }
        }
        .navigationTitle("Create Program")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("save") {
                    
                }
                .disabled(programName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateProgramView()
            .environment(AppCoordinator())
    }
}
