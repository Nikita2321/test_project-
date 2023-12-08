import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> houseList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Flutter App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                
                setState(() {
                  houseList.add('New House ${houseList.length + 1}');
                });
              },
              child: Text('Add House'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: houseList.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    child: Text(houseList[index]),
                    onPressed: () {
                     
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}  