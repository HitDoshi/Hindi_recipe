import 'package:flutter/material.dart';
import 'package:hindi_recipe/database/DBHandler.dart';
import 'package:hindi_recipe/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

     body:Container(

           constraints: BoxConstraints.expand(),
           decoration: const BoxDecoration(
             image: DecorationImage(
                 image: AssetImage("assets/images/chief.webp"),
                 fit: BoxFit.fill),
           ),


           child: TextButton(
              child: const Text("प्रवेश",style: TextStyle(backgroundColor: Colors.green),),
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.listRecipes);
              },

           )
    )
    );

  }
}
