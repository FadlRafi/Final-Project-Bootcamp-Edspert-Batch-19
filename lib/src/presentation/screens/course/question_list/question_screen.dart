import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/question_response_entity.dart';
import 'package:learn_apps/src/presentation/blocs/course_list_bloc/course_list_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/course/widgets/question_widget.dart';
import 'package:learn_apps/src/value/colors.dart';

class QuestionListArgs {
  final String exerciseId;

  QuestionListArgs({required this.exerciseId});
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

int current = 0;

class _QuestionScreenState extends State<QuestionScreen> {
  String exerciseId = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    if (args is QuestionListArgs) {
      exerciseId = args.exerciseId;
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<CourseListBloc>()
          .add(GetQuestionEvent(exerciseId: exerciseId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Soal'),
        backgroundColor: AppColor.bluePrimary,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          setState(() {
            current = 0;
            context.read<CourseListBloc>().add(GetCourseListEvent(majorName: 'IPA'));
          });
          Navigator.pushNamed(context, Routes.courseListScren);
        }, icon:const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          if (state is QuestionSucces) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                QuestionDataEntity data = state.data![current];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    QuestionWidget(data: data, now: current,),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      height: 35,
                      width: 135,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.bluePrimary),
                          fixedSize:
                              const MaterialStatePropertyAll(Size(135, 35)),
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () {
                          setState(() {
                            current++;
                            if (current > 9) {
                              current = 0;
                            }
                          });
                        },
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
