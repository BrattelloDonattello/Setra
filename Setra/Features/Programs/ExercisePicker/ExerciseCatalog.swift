import Foundation

enum ExerciseCatalog {

    static let exercises: [Exercise] = [
        Exercise(
            name: "Bench Press",
            muscleGroup: .chest
        ),
        Exercise(
            name: "Incline Bench Press",
            muscleGroup: .chest
        ),
        Exercise(
            name: "Chest Fly",
            muscleGroup: .chest
        ),
        Exercise(
            name: "Shoulder Press",
            muscleGroup: .shoulders
        ),
        Exercise(
            name: "Lateral Raise",
            muscleGroup: .shoulders
        ),
        Exercise(
            name: "Lat Pulldown",
            muscleGroup: .back
        ),
        Exercise(
            name: "Seated Row",
            muscleGroup: .back
        ),
        Exercise(
            name: "Biceps Curl",
            muscleGroup: .biceps
        ),
        Exercise(
            name: "Triceps Pushdown",
            muscleGroup: .triceps
        ),
        Exercise(
            name: "Squat",
            muscleGroup: .legs
        )
    ]
}
