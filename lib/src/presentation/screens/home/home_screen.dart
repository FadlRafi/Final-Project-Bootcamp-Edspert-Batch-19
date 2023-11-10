import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/course_list_bloc/course_list_bloc.dart';
import 'package:learn_apps/src/presentation/screens/course/course_list/course_list_screen.dart';
import 'package:learn_apps/src/presentation/screens/home/widgets/banner_list.dart';
import 'package:learn_apps/src/presentation/screens/home/widgets/course_builder.dart';
import 'package:learn_apps/src/value/colors.dart';
import 'package:learn_apps/src/value/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BannerBloc>().add(GetBannerListEvent());
      context.read<CourseListBloc>().add(GetCourseListEvent(majorName: 'IPA'));
    });
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi ${FirebaseAuth.instance.currentUser!.displayName}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 23.5,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      backgroundImage: const NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/5556/5556512.png'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: AppColor.bluePrimary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 26),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Mau kerjain\nlatihan soal\napa hari ini?',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/Group.png',
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      Strings.pilihPelajaran,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CourseListScreen(),
                            ));
                      },
                      child: const Text('Lihat Semua',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF3A7FD5))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<CourseListBloc, CourseListState>(
                  builder: (context, state) {
                    if (state is CourseListSucces) {
                      return CourseBuilder(courseList: state.data ?? []);
                    } else if (state is CourseListFailed) {
                      return Center(
                        child: Text(state.message ?? ''),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  'Terbaru',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<BannerBloc, BannerState>(
                  builder: (context, state) {
                    print('${state.runtimeType}');
                    if (state is BannerFailed) {
                      return Center(
                        child: Text(state.message ?? ''),
                      );
                    } else if (state is BannerSucces) {
                      return BannerListWidget(bannerList: state.banner.data);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
