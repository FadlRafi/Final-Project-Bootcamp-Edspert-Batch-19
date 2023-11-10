import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/domain/entity/question_response_entity.dart';
import 'package:learn_apps/src/domain/usecase/course/get_course_usecase.dart';
import 'package:learn_apps/src/domain/usecase/course/get_exercise_usecase.dart';
import 'package:learn_apps/src/domain/usecase/course/get_question_usecase.dart';
import 'package:meta/meta.dart';

part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  final GetCourseUsecase getCourseUsecase;
  final GetExerciseUsecase getExerciseUsecase;
  final GetQuestionUsecase getQuestionUsecase;

  CourseListBloc(this.getCourseUsecase, this.getExerciseUsecase, this.getQuestionUsecase) : super(CourseListInitial()) {
    on<CourseListEvent>((event, emit)async {
      if(event is GetCourseListEvent){
        emit(CourseListLoading());

        final List<CourseDataEntity>? result = await getCourseUsecase(event.majorName);

        emit(CourseListSucces(result));
      }

      if(event is GetExerciseEvent){
        emit(ExerciseLoading());

        final List<ExerciseDataEntity>? getExercise = await getExerciseUsecase(event.courseId);
        if(getExercise == null){
          emit(ExerciseFailed('Somthing wrong'));
        }
        else{
          emit(ExerciseSucces(getExercise));
        }
      }

      if(event is GetQuestionEvent){
        emit(QuestionLoading());

        final List<QuestionDataEntity>? getQuestion = await getQuestionUsecase(event.exerciseId);
        if(getQuestion == null){
          emit(QuestionFailed('Somthing wrong'));
        }
        else{
          emit(QuestionSucces(getQuestion));
        }
      }
    });
  }
}
