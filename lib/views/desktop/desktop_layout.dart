import 'package:flutter/material.dart';
import 'package:inkflow/views/shared/dashboard.dart';
import 'package:inkflow/views/desktop/components/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Row(
      children: [
        Expanded(flex: 1, child: Sidebar()),
        Expanded(flex: 4, child: Dashboard()),
      ],
    ));
  }
}
