import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/presentation/blocs/course_list_bloc/course_list_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/course/widgets/course_list_item_widget.dart';
import 'package:learn_apps/src/value/colors.dart';
import 'package:learn_apps/src/value/strings.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CourseListBloc>().add(GetCourseListEvent(majorName: 'IPA'));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListBloc, CourseListState>(
      buildWhen: (prev, next) =>
          next is CourseListLoading ||
          prev is CourseListLoading && next is CourseListSucces ||
          prev is CourseListLoading && next is CourseListFailed,
      builder: (context, state) {
        Widget body = const SizedBox();

        if (state is CourseListLoading) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CourseListSucces) {
          body = ListView.separated(
            itemCount: state.data!.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemBuilder: (context, index) {
              CourseDataEntity data = state.data![index];
              return CourseListItemWidget(data: data);
            },
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF3F7F8),
          appBar: AppBar(
            backgroundColor: AppColor.bluePrimary,
            foregroundColor: Colors.white,
            title: const Text(
              Strings.pilihPelajaran,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  setState(() {
                    context.read<CourseListBloc>().add(GetCourseListEvent(majorName: 'IPA'));
                  });
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: body,
        );
      },
    );
  }
}
