import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  

class MyWidget extends StatelessWidget {
 
  static const platform = MethodChannel('example.channel');

 
  Future<void> _doSomethingNative() async {
    try {
  
      final String result = await platform.invokeMethod('doSomething');
      print('Result from platform: $result');
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Test task',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Image.network(
            'https://img.lexica.art/9bf6a0bc-0321-4c30-8f53-2cc6753a4490_full.webp',
            width: 250,
            height: 350,
          ),
          ElevatedButton(
            onPressed: () {
           
              _doSomethingNative();
            },
            child: Text(
              'Enter',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            bottom: 33333,
            child: Text(
              "designed by...",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}