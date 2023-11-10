import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/presentation/blocs/course_list_bloc/course_list_bloc.dart';
import 'package:learn_apps/src/presentation/screens/course/widgets/exercise_grid_item_widget.dart';
import 'package:learn_apps/src/value/colors.dart';

class ExerciseListArgs {
  final String courseId;
  final String courseName;

  ExerciseListArgs({required this.courseId, required this.courseName});
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String courseName = '';
  String courseId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    if (args is ExerciseListArgs) {
      courseName = args.courseName;
      courseId = args.courseId;
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CourseListBloc>().add(GetExerciseEvent(courseId: courseId));
      context.read<CourseListBloc>().add(GetCourseListEvent(majorName: 'IPA'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            courseName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, Routes.courseListScren);
          //     },
          //     icon: const Icon(Icons.arrow_back)),
          backgroundColor: AppColor.bluePrimary,
        ),
        body: BlocBuilder<CourseListBloc, CourseListState>(
          builder: (context, state) {
            if (state is ExerciseSucces) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'Pilih Paket Soal',
                        style: TextStyle(
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.2),
                        itemCount: state.data!.length,
                        itemBuilder: (context, index) {
                          ExerciseDataEntity data = state.data![index];
                          return ExerciseGridItemWidget(data: data);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
