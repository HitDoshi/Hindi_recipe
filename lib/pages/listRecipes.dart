import 'package:flutter/material.dart';
import 'package:hindi_recipe/pages/listitem.dart';
import 'package:hindi_recipe/utils/datanode.dart';
import 'package:hindi_recipe/utils/routes.dart';

import '../database/DBHandler.dart';

class ListRecipes extends StatefulWidget {
  const ListRecipes({Key? key}) : super(key: key);

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {

  DBHandler? dbHandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler  = DBHandler();
    print("Hello");
  }

  late int type_id;
  late String item_name;
  List<String> items = ["नाश्ता","पराठा","सलाद"];
  List<String> images = ["assets/images/nashta.webp","assets/images/paratha.webp","assets/images/salad.webp"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
          title: const Text("हिंदी रेसिपीज"),
        ),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(

            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context,index){

              return GestureDetector(
                onTap: (){
                    type_id = index ;
                    item_name = items[index];
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        ListItem(id: type_id, recipe: item_name)));
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