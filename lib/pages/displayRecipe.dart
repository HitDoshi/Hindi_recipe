import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/FavDBHandler.dart';
import 'package:hindi_recipe/utils/favmodel.dart';

class DisplayRecipe extends StatefulWidget {

  final int type_id , row_id ;
  final fav;
  final String recipe_name , sahitya , kruti , recipe_image;

  final int? fav_id;

  const DisplayRecipe({Key? key,required this.type_id,required this.row_id,
    required this.recipe_name,required this.recipe_image , required this.sahitya,
    required this.kruti,required this.fav,required this.fav_id}) : super(key: key);

  @override
  State<DisplayRecipe> createState() => _DisplayRecipeState();
}

class _DisplayRecipeState extends State<DisplayRecipe> {

  FavDBHandler? favDBHandler;
  List<FavModel> readFavData = [];
  late String star;
  late int f, id ;
  late String t_id , r_id;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    f = widget.fav;

    if(widget.fav==1)
    {
      star = "assets/images/starred.png";
    }
    else{
      star = "assets/images/stargray.png";
    }

    favDBHandler = FavDBHandler();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.recipe_name),
        actions: [
          Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child:IconButton(
              onPressed: () async {

                print("press");
                readFavData = (await favDBHandler!.readData());
                print("fa==${readFavData.length.toString()}");

                for(int i=0;i<readFavData.length;i++){

                  print("${readFavData[i].type_id} ${widget.type_id.toString()} "
                      "${readFavData[i].row_id.toString()} ${widget.row_id.toString()}");
                  /*print(widget.type_id.toString());
                  print(readFavData[i].row_id.toString());
                  print(widget.row_id.toString());
*/
                  if( (readFavData[i].type_id.toString()==widget.type_id.toString())
                      && (readFavData[i].row_id.toString()==widget.row_id.toString()) ) {

                    f = readFavData[i].fav;
                    t_id = readFavData[i].type_id;
                    r_id = readFavData[i].row_id;


                    print("f=$f");
                  }
                }

                if(f==1) {
                  print("delete");
                  favDBHandler!.delete(t_id,r_id);
                  f=0;
                  setState(() {
                    star = "assets/images/stargray.png";
                  });
                }
                else{
                  print("f=$f");

                  await favDBHandler?.insert(FavModel(
                      type_id: (widget.type_id).toString(),
                      row_id: (widget.row_id).toString(),
                      name: widget.recipe_name,
                      sahitya: widget.sahitya,
                      kruti: widget.kruti,
                      fav: 1)
                  ).then((value) =>
                      print("Inserted ${widget.recipe_name}")).
                  onError((error, stackTrace) =>
                      print(error.toString()));
                  //widget.fav = 1;
                  setState(() {
                    star = "assets/images/starred.png";
                  });
                }
              },
              icon: Image.asset(star,))
          ),
        ],
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child: Image.asset(widget.recipe_image,height: 200,)),

              const Padding(
               child: Text("-: सामग्री :-",textScaleFactor: 1.8,style: TextStyle(color: Colors.red,)),
                padding: EdgeInsets.all(10),),
              Text(widget.sahitya,textScaleFactor: 1.2),

              Container(
                decoration: const BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),)
              ),

              const Padding(
                child: Text("-: रीत :-",textScaleFactor: 1.8,style: TextStyle(color: Colors.red)),
                padding: EdgeInsets.all(10),),

              Text(widget.kruti,textScaleFactor: 1.2,)
            ],

          ),
        ),
      ),
    );
  }
}
