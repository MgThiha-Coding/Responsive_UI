import 'package:flutter/material.dart';
import 'package:inkflow/views/shared/dashboard.dart';

import 'package:inkflow/views/shared/app_drawer.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: const Dashboard(),
    );
  }
}
