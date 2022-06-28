import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/FavDBHandler.dart';
import 'package:hindi_recipe/utils/favmodel.dart';

import '../utils/datanode.dart';
import 'DisplayFavRecipe.dart';
import 'displayRecipe.dart';

class FavItemDisplay extends StatefulWidget {

  final List<FavModel> favData;

  const FavItemDisplay({Key? key,required this.favData}) : super(key: key);

  @override
  State<FavItemDisplay> createState() => _FavItemDisplayState();
}

class _FavItemDisplayState extends State<FavItemDisplay> {

  FavDBHandler? favDBHandler;
  List<FavModel> readFavData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favDBHandler = FavDBHandler();
    readFavData = widget.favData;
  }

  List<List<String>> imaegItem = [
    ["assets/images/a1.webp"],
    ["assets/images/b1.webp"],
    ["assets/images/c1.webp"]
  ];

  @override
  Widget build(BuildContext context) {

    a();

    return Scaffold (
      appBar: AppBar(
        title: const Text("मनपसंद रेसिपी"),
      ),


      body: ListView.builder(

          padding: const EdgeInsets.fromLTRB(0, 5, 2, 5),// recyclerview = Listview.builder

          itemCount: readFavData.length,

          itemBuilder: (BuildContext context, int index) {

            return Container(
              decoration: const BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),

              child: Padding(
                padding: const EdgeInsets.all(10),

                child: ListTile(

                    onTap: () async {

                      final FavData = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              DisplayFavRecipe(type_id: int.parse(readFavData[index].type_id),
                                row_id: int.parse(readFavData[index].row_id),
                                recipe_name: readFavData[index].name ,
                                recipe_image: imaegItem[int.parse(readFavData[index].type_id)-1][0],
                                sahitya:readFavData[index].sahitya,
                                kruti: readFavData[index].kruti,fav: 1,fav_id: readFavData[index].id)
                          ));

                      setState(() {
                        readFavData = FavData;
                      });
                    },

                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child:Image.asset(imaegItem[int.parse(readFavData[index].type_id)-1][0])),
                    title: Text(readFavData[index].name)
                ),
              ),
            );
          }),

    );
  }

  a() async {
    readFavData = (await favDBHandler?.readData())!;
    print("abc");
  }

}




