
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  // final Function(int) onTap;

  // AppBottomNavigationBar({required this.currentIndex, required this.onTap});
  AppBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Раздел 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.redo_sharp),
          label: 'Раздел 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Раздел 3',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      onTap: (value){print(value);},
    );
  }
}