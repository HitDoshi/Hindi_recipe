import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/FavDBHandler.dart';
import 'package:hindi_recipe/utils/favmodel.dart';

import '../utils/datanode.dart';

class FavItemDisplay extends StatefulWidget {
  const FavItemDisplay({Key? key}) : super(key: key);

  @override
  State<FavItemDisplay> createState() => _FavItemDisplayState();
}

class _FavItemDisplayState extends State<FavItemDisplay> {

  FavDBHandler? favDBHandler;
  List<FavModel> readData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favDBHandler = FavDBHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (

    );
  }
}


