import Foundation

protocol StartWorkoutUseCase {
    func execute(program: WorkoutProgram) async throws -> WorkoutSession
}

final class DefaultStartWorkoutUseCase: StartWorkoutUseCase {
    func execute(program: WorkoutProgram) async throws -> WorkoutSession {
        let workoutExercises = program.exercise
            .sorted {
                $0.order < $1.order
            }
            .enumerated()
            .map { index, programExercise in
                WorkoutExercise(
                    exerciseID: programExercise.exercises.id,
                    exerciseName: programExercise.exercises.name,
                    order: index,
                    sets: [
                        WorkoutSet(order: 0)
                    ]
                )
            }
        
        
        return WorkoutSession(programID: program.id, programName: program.name, exercises: workoutExercises)
    }
}
