import Foundation

enum AppRoute: Hashable {
    case createProgram
    case exercisePicker
    case programDetails(UUID)
    case activeWorkout
    case workoutDetails(UUID)
}
