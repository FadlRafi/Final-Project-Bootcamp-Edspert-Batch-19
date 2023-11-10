import 'package:flutter/material.dart';
import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/presentation/screens/course/widgets/course_list_item_widget.dart';

class CourseBuilder extends StatelessWidget {
  final List<CourseDataEntity> courseList;
  // final bool isHomescreen;
  const CourseBuilder({
    super.key,
    required this.courseList,
    // this.isHomescreen = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courseList.length > 3 ? 3 : courseList.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) {
        return CourseListItemWidget(data: courseList[index]);
      },
    );
  }
}
