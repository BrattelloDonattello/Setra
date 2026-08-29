import SwiftUI

struct CreateProgramView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    var body: some View {
        if let viewModel = coordinator.createProgramViewModel {
            content(viewModel: viewModel)
        } else {
            ContentUnavailableView("Something went wrong", systemImage: "exclamationmark.triangle")
        }
    }
    
    @ViewBuilder
    private func content(viewModel: CreateProgramViewModel) -> some View {
        @Bindable var viewModel = viewModel
        
        Form {
            Section ("Program Name") {
                TextField("Push Day", text: $viewModel.name)
            }
            
            Section ("Exercises") {
                if viewModel.selectedExercises.isEmpty {
                    Text("No Exercises selected")
                        .foregroundStyle(.secondary)
                }
                
                ForEach(viewModel.selectedExercises) { exercises in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercises.name)
                            
                            Text(exercises.muscleGroup.title)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.removeExercise(exercises)
                    } label: {
                        Image(systemName: "minus.circle")
                            .foregroundStyle(.red)
                    }
                }
                
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
                Button("Save") {
                    // Save program
                }
                .disabled(!viewModel.canSave)
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
