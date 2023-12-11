import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final_project_ang/nba/player.dart';
import 'edit.dart';
import 'details.dart';
import 'nba/team.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = List.generate(5, (index) => 'Item $index');
  List<Player> players = [];

  // get teams
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/players'));
    var jsonData = jsonDecode(response.body);

    for (var eachPlayer in jsonData['data']) {
      final player = Player(
        id: eachPlayer['id'],
        first_name: eachPlayer['first_name'],
        last_name: eachPlayer['last_name'],
        position: eachPlayer['position'],
      );
      players.add(player);
    }
  }

  void addItem() {
    setState(() {
      items.add('New Item ${items.length}');
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void editItem(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(initialText: items[index]),
      ),
    );

    if (result != null) {
      setState(() {
        items[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        title: Text('List Builder Example'),
      ),
      body: Column(
        children: [
          //devControls(),             //This is for adding and deleting objects in the list if needed
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              'Top 5 Best Players of the Week',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          listWeekly(),
          //SizedBox(width: 500, height: 10,),
          Text('asdsadsa'),
        ],
      ),
    );
  }

  Expanded listWeekly() {
    return Expanded(
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(players[index].first_name),
            subtitle: Text(players[index].position),
            onTap: () {
              // Navigate to the details screen when the list tile is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(item: items[index]),
                ),
              );
            },
            onLongPress: () {
              // Delete the item when the list tile is long-pressed
              deleteItem(index);
            },
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Edit the item when the edit button is pressed
                editItem(index);
              },
            ),
          );
        },
      ),
    );
  }

  Padding devControls() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: addItem,
            child: Text('Add Item'),
          ),
          SizedBox(width: 5,),
          ElevatedButton(
            onPressed: items.isNotEmpty ? () => deleteItem(items.length - 1) : null,
            child: Text('Delete Last Item'),
          ),
        ],
      ),
    );
  }
}