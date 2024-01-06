import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Welcome"),
      )
    );
  }
}