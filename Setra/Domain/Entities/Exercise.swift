
import Foundation

struct Exercise: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let muscleGroup: MuscleGroup

    init(
        id: UUID = UUID(),
        name: String,
        muscleGroup: MuscleGroup
    ) {
        self.id = id
        self.name = name
        self.muscleGroup = muscleGroup
    }
}

