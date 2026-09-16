
import Foundation

extension SDWorkoutSet {
    func toDomain() -> WorkoutSet {
        WorkoutSet(
            id: id,
            weight: weight,
            reps: reps,
            isCompleted: isCompleted
        )
    }
    
    static func fromDomain(_ set: WorkoutSet) -> SDWorkoutSet {
        SDWorkoutSet(
            id: set.id,
            weight: set.weight,
            reps: set.reps,
            isCompleted: set.isCompleted
        )
    }
}

extension SDWorkoutExercise {
    func toDomain() -> WorkoutExercise {
        WorkoutExercise(
            id: id,
            exerciseID: exerciseID,
            exerciseName: exerciseName,
            sets: sets.map {
                $0.toDomain()
            }
        )
    }
    
    static func fromDomain(_ exercise: WorkoutExercise) -> SDWorkoutExercise {
        SDWorkoutExercise(
            id: exercise.id,
            exerciseID: exercise.exerciseID,
            exerciseName: exercise.exerciseName,
            sets: exercise.sets.map {
                SDWorkoutSet.fromDomain($0)
            }
        )
    }
}

extension SDWorkoutSession {
    func toDomain() -> WorkoutSession {
        WorkoutSession(
            id: id,
            programID: programID,
            programName: programName,
            startedAt: startedAt,
            finishedAt: finishAt,
            exercises: exercises.map {
                $0.toDomain()
            }
        )
    }
    
    
    static func fromDomain(_ workout: WorkoutSession) -> SDWorkoutSession {
        SDWorkoutSession(
            id: workout.id,
            programID: workout.programID,
            programName: workout.programName,
            startedAt: workout.startedAt,
            finishAt: workout.finishedAt,
            exercises: workout.exercises.map {
                SDWorkoutExercise.fromDomain($0)
            }
        )
    }
    
    func update(from workout: WorkoutSession) {
        programID = workout.programID
        programName = workout.programName
        startedAt = workout.startedAt
        finishAt = workout.finishedAt
        
        exercises = workout.exercises.map {
            SDWorkoutExercise.fromDomain($0)
        }
    }
}
