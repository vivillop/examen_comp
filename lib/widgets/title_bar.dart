import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String screenName;
  final Color color;
  const TitleBar(
      {super.key,
      required this.screenName,
      this.color = const Color.fromARGB(255, 51, 2, 44)});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            screenName,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const Expanded(
            child: Text(""),
          ),
        ],
      ),
    );
  }
}
