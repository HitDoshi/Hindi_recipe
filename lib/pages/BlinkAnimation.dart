import 'package:flutter/material.dart';
import '../utils/routes.dart';

class MyBlinkingButton extends StatefulWidget {
  const MyBlinkingButton({Key? key}) : super(key: key);

  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
          child: OutlinedButton(
            style: TextButton.styleFrom(alignment: Alignment.topCenter,padding: const EdgeInsets.all(100)),
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.listRecipes);
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(20)
                ),
              height: 50,
              width: 80,
                child: const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text("प्रवेश",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)
                )
            ),
          ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}