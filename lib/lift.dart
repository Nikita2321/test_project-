import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Flutter App'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ElevatedButton(
              child: Text('HOUSE ${index + 1}'),
              onPressed: () {
      
                setState(() {
                  _currentButtonIndex = index;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _currentButtonIndex == index
                      ? Colors.green
                      : Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
