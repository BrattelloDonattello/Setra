
import Foundation

enum MuscleGroup: String, Codable, CaseIterable, Hashable {
    case chest
    case back
    case shoulders
    case biceps
    case triceps
    case legs
    case core

    var title: String {
        switch self {
        case .chest:
            "Chest"
        case .back:
            "Back"
        case .shoulders:
            "Shoulders"
        case .biceps:
            "Biceps"
        case .triceps:
            "Triceps"
        case .legs:
            "Legs"
        case .core:
            "Core"
        }
    }
}
