import Foundation

protocol StartWorkoutUseCase {
    func execute(program: WorkoutProgram) async throws -> WorkoutSession
}

final class DefaultStartWorkoutUseCase: StartWorkoutUseCase {
    func execute(program: WorkoutProgram) async throws -> WorkoutSession {
        let workoutExercises = program.exercise.sorted {
            $0.order < $1.order
        }
            .map { programExercises in
                WorkoutExercise(exerciseID: programExercises.exercises.id, exerciseName: programExercises.exercises.name, sets: [WorkoutSet()])
            }
        
        
        return WorkoutSession(programID: program.id, programName: program.name, exercises: workoutExercises)
    }
}
