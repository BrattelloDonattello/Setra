import Foundation

extension SDWorkoutProgram {
    func toDomain() -> WorkoutProgram {
        WorkoutProgram(
            id: id,
            name: name,
            exercise: exercises.sorted{ $0.order < $1.order }.map{ $0.toDomain() }
        )
    }
    
    static func fromDomain(_ program: WorkoutProgram) -> SDWorkoutProgram {
        SDWorkoutProgram(
            id: program.id,
            name: program.name,
            exercises: program.exercise.map{SDProgramExercise.fromDomain($0)}
        )
    }
    
    func update(from program: WorkoutProgram) {
        name = program.name
        
        exercises.removeAll()
        
        exercises = program.exercise.map{
            SDProgramExercise.fromDomain($0)
        }
    }
}

extension SDProgramExercise {
    func toDomain() -> ProgramExercises {
        let muscleGroup = MuscleGroup(rawValue: muscleGroupRawValue) ?? .chest
        
        return ProgramExercises(
            id: id,
            exercises: Exercise(
                id: id,
                name: exerciseName,
                muscleGroup: muscleGroup
            ), order:
                order
        )
    }
    
    static func fromDomain(_ programExercise: ProgramExercises) -> SDProgramExercise {
        SDProgramExercise(
            id: programExercise.id,
            exerciseID: programExercise.exercises.id,
            exerciseName: programExercise.exercises.name,
            muscleGroupRawValue: programExercise.exercises.muscleGroup.rawValue,
            order: programExercise.order
        )
    }
}
