import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/FavDBHandler.dart';
import 'package:hindi_recipe/pages/listitem.dart';
import 'package:hindi_recipe/utils/datanode.dart';
import 'package:hindi_recipe/utils/favmodel.dart';
import 'package:hindi_recipe/utils/routes.dart';
import '../database/DBHandler.dart';
import 'favItemDisplay.dart';

class ListRecipes extends StatefulWidget {
  const ListRecipes({Key? key}) : super(key: key);

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {

  DBHandler? dbHandler;
  FavDBHandler? favDBHandler;
  List<DataNode> readData = [];
  List<FavModel> readFavData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler = DBHandler();
    favDBHandler = FavDBHandler();
    print("Hello");
  }

  late int type_id;
  late String item_name;
  List<String> items = ["नाश्ता", "पराठा", "व्रत के फलाहार"];
  List<String> images = [
    "assets/images/nashta.webp",
    "assets/images/paratha.webp",
    "assets/images/salad.webp"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("हिंदी रेसिपीज"),
        actions: [
          IconButton(
            onPressed: () async {
              readFavData = await favDBHandler!.readData();

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      FavItemDisplay(favData: readFavData)
                  ));
            },
            icon: Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset("assets/images/fav.png",)),

          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(

            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  dbHandler?.initDb();
                  readData = (await dbHandler?.getData(index + 1))!;
                  type_id = index;
                  item_name = items[index];
                  print("Recipe${readData.length}");
                  //print(index);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          ListItem(type_id: type_id,
                              recipe: item_name,
                              list: readData)));
                },

                child: Card(
                  elevation: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(images[index],
                          height: 130,),
                        Text(items[index],
                          textScaleFactor: 1.3,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),

    );
  }
}

/* body: Center(
          child: ElevatedButton( onPressed: () {

            dbHandler?.insert(DataNode(
              title : 'First',
              subtitle: 'SubFirst'
            )
            ).then((value) {
              print("Added");
            }).
            onError((error, stackTrace) {
              print(error.toString() +  "Hit");
            } );
          },
          child:
            const Text("ADD"),)),*/