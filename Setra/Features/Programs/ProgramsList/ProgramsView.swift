
import SwiftUI

struct ProgramsView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    @State private var viewModel: ProgramsListViewModel
    
    private let makeCreateProgramViewModel: () -> CreateProgramViewModel
    
    init(
        viewModel: ProgramsListViewModel,
        makeCreateProgramViewModel: @escaping () -> CreateProgramViewModel
    ) {
        _viewModel = State(initialValue: viewModel)
        
        self.makeCreateProgramViewModel = makeCreateProgramViewModel
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.programs.isEmpty {
                ContentUnavailableView("No Programs", systemImage: "dumbbell", description: Text("Create your first workout program."))
            } else {
                List(viewModel.programs) { program in
                    Button {
                        coordinator.navigate(to: .programDetails(program.id))
                    } label: {
                        programRow(program)
                    }.buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Programs")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    coordinator.startCreateProgram(viewModel: makeCreateProgramViewModel())
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadPrograms()
            }
        }
    }
    
    private func programRow(_ program: WorkoutProgram) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(program.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("\(program.exercise.count) exercise")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .contentShape(Rectangle())
    }
}
