import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF333745),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.flag_outlined),
          onPressed: () {
          },
        ),
      ],
    );
  }
}
