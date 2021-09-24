import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:we_helper_1/pages/SideBar.dart/tabs/TktDateCalculator.dart';
import 'package:we_helper_1/pages/webView.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        width: 50,
        color: Color.fromRGBO(0, 23, 51, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...tab(
              context,
              title: "date calc",
              icon: MaterialCommunityIcons.calendar_clock,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (c) => TktDateCalculator(),
                );
              },
            ),
          ],
        ));
  }

  List<Widget> tab(BuildContext context,
      {String title = "title",
      IconData icon = Icons.block,
      void Function()? onTap}) {
    return [
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
