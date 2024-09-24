import 'package:flutter/material.dart';
import 'package:turf_trek/Widgets/background_theme.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {

  final List<Color> gradientColors = [Colors.blue, Colors.green];
  final List<double> borderThickness = [3.0, 5.0, 10.0, 8.0]; // Left, Top, Right, Bottom

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackGroundTheme(),
      child: Scaffold(
        backgroundColor: Colors.yellow.shade50.withOpacity(0.9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('data'),
        ),

        body: Center(
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.circular(10.0)
              ),
              fillColor: Colors.yellow.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
            ),
          ),
          /*Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.pinkAccent,
                ],
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: TextField(

              ),
            ),
          ),*/
        ),
      ),
    );
  }
}
