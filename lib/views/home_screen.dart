import 'package:flutter/material.dart';
import 'package:inkflow/views/desktop/desktop_layout.dart';
import 'package:inkflow/views/mobile/mobile_layout.dart';
import 'package:inkflow/views/tablet/tablet_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrants) {
      if (constrants.maxWidth < 750) {
        return const MobileLayout();
      } else if (constrants.maxWidth < 1200) {
        return const TabletLayout();
      } else {
        return const DesktopLayout();
      }
    });
  }
}
