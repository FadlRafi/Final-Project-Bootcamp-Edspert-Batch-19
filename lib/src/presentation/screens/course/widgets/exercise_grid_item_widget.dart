import 'package:flutter/material.dart';
import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/course/question_list/question_screen.dart';

class ExerciseGridItemWidget extends StatelessWidget {
  const ExerciseGridItemWidget({super.key, required this.data});
  final ExerciseDataEntity data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.questionScreen,
              arguments: QuestionListArgs(exerciseId: data.exerciseId));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(bottom: 7),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]),
                child: Image.network(
                  data.icon,
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 30,
                    width: 30,
                    color: Colors.red,
                  ),
                ),
              ),
              Text(
                data.exerciseTitle,
                maxLines: 1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${data.jumlahDone}/${data.jumlahSoal} Soal',
                style: const TextStyle(color: Color(0xFF8E8E8E)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
