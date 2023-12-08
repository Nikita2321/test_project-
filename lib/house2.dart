import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HouseDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // Если база данных еще не создана, инициализируем ее
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'house_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE houses (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insertHouse(String name) async {
    final Database db = await database;

    await db.insert(
      'houses',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<String>> getHouses() async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.query('houses');

    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textEditingController = TextEditingController();
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
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter House Name',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await HouseDatabase.insertHouse(_textEditingController.text);
                      _textEditingController.clear();
                      _updateHouseList();
                    },
                    child: Text('Add House'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: HouseDatabase.getHouses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    houseList = snapshot.data!;
                    return ListView.builder(
                      itemCount: houseList.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          child: Text(houseList[index]),
                          onPressed: () {
                            // Действие при нажатии на кнопку
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateHouseList() {
    setState(() {
      houseList = [];
    });
  }
}

void main() {
  runApp(MyApp());
}