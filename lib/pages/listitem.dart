import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/FavDBHandler.dart';
import 'package:hindi_recipe/utils/favmodel.dart';

import '../database/DBHandler.dart';
import '../utils/datanode.dart';
import 'displayRecipe.dart';

class ListItem extends StatefulWidget {

  final int type_id;
  final String recipe;
  final List<DataNode> list;
  const ListItem({Key? key,required this.type_id,required this.recipe,required this.list}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  DBHandler? dbHandler;
  FavDBHandler? favDBHandler;
  List<DataNode> readData = [];
  List<FavModel> readFavData = [];
  int temp = 0 , id=0 ;

  List<List<String>> imaegItem = [
    ["assets/images/a1.webp"],
    ["assets/images/b1.webp"],
    ["assets/images/c1.webp"]
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler  = DBHandler();
    favDBHandler = FavDBHandler();
    //print("item${widget.list.length}");
      //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe),
      ),

      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 5, 2, 5),// recyclerview = Listview.builder

          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {

            return Container(
              decoration: const BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),

              child: Padding(
                padding: const EdgeInsets.all(10),
                
                child: ListTile(
                  
                  onTap: () async {
                    //favDBHandler?.initDb();
                    readFavData = (await favDBHandler!.readData());

                    print(readFavData.length.toString());

                    for(int i=0;i<readFavData.length;i++){

                      /*print("ty=${readFavData[i].type_id}");
                      print("type=${widget.type_id+1}");
                      print(readFavData[i].row_id.toString());
                      print(index+1);
*/
                      if(readFavData[i].type_id.toString()==(widget.type_id +1).toString()&& readFavData[i].row_id.toString()==(index+1).toString()){
                        temp = readFavData[i].fav;
                        id = readFavData[i].id!;
                        print("Enter");
                      }
                    }

                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            DisplayRecipe(type_id: widget.type_id + 1, row_id: index + 1,
                              recipe_name: widget.list[index].name ,
                              recipe_image: imaegItem[widget.type_id][0], sahitya:widget.list[index].sahitya,
                              kruti: widget.list[index].kruti,fav: temp,fav_id: id,)));
                  },

                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                      child:Image.asset(imaegItem[widget.type_id][0])),
                    title: Text(widget.list[index].name)
                ),
              ),
            );
          }),

    );
  }
}
