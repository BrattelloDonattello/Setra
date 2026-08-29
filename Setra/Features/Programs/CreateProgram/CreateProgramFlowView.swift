import SwiftUI

struct CreateProgramFlowView: View {
    @State private var viewModel = CreateProgramViewModel()
    
    var body: some View {
        CreateProgramView()
            .environment(viewModel)
    }
}

#Preview {
    CreateProgramFlowView()
}
