import 'package:flutter/material.dart';
import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/course/exercise_list/exercise_screen.dart';

class CourseListItemWidget extends StatelessWidget {
  final CourseDataEntity data;
  const CourseListItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.exerciseScreen,
          arguments: ExerciseListArgs(
              courseId: data.courseId, courseName: data.courseName),
        );
      },
      child: Container(
        width: 320,
        height: 96,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Image.network(
                data.urlCover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 30,
                  width: 30,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.courseName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data.jumlahDone}/${data.jumlahMateri} Paket latihan Soal',
                    style: const TextStyle(color: Color(0xFF8E8E8E)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    value: data.jumlahDone /
                        (data.jumlahMateri == 0 ? 1 : data.jumlahMateri),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
