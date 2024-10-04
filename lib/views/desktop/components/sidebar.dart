import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    double fontsize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(
              child: Text(
            'InkFlow',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: fontsize * 0.030,
                color: const Color.fromARGB(255, 33, 243, 44)),
          )),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
        ],
      ),
    );
  }
}
