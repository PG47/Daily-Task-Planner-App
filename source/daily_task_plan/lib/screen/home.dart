import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks Manager',
          style: GoogleFonts.robotoFlex(),
        ),
      ),
      body: Center(
        child: Text('No tasks added yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.green,
        ),
        backgroundColor: Colors.red,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Container(
                  //height: 500,
                  color: Colors.blue[200],
                  child: Column(
                    children: [
                      Text(
                        'ADD TASK',
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
