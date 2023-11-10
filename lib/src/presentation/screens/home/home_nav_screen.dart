import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/nav_cubit/nav_cubit.dart';
import 'package:learn_apps/src/presentation/screens/home/home_screen.dart';
import 'package:learn_apps/src/presentation/screens/profile/profile_screen.dart';

class HomeNavigationScreen extends StatelessWidget {
  HomeNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, HomeNav>(
      builder: (context, state) {
        return Scaffold(
          body: nav[state.index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Diskusi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              context.read<HomeNavCubit>().navTo(HomeNav.values[index]);
            },
          ),
        );
      },
    );
  }

  final List<Widget> nav = [
    const HomeScreen(),
    const Placeholder(),
    const ProfileScreen(),
  ];
}