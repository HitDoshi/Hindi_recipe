import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final int id;
  final String recipe;
  const ListItem({Key? key,required this.id,required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(recipe),
      ),

      body: Center(
          child: Text(id.toString())
      ),

    );
  }
}
