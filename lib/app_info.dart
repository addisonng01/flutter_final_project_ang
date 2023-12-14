import 'package:flutter/material.dart';

String info = "The NBA Player Index is a Flutter application that displays players pulled from balldontlie.io API. The purpose of this application is to be able to sort through players and view their data. Currently, the application contains NBA players from the 2023-2024 NBA season. The teams that are able to be viewed are:\n\nOrlando Magic\nBoston Celtics\nNew York Knicks\nToronto Raptors\nWashington Wizards\n\nThe players are displayed in a Card widget that tells you the player's name, the position they play, and an image of the team that they play for.";

class appInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.cyanAccent,
        child: Center(
          child: Column(
            children: [
              const Text(
                'NBA Player Index',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(info, style: const TextStyle(fontSize: 20,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final team in ['orl', 'bos', 'nyk', 'tor', 'was'])
                            Image.asset(
                              '$team.png',
                              width: 150,
                              height: 150,
                            ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("You can click on a player's card to read more details about that player.\n" "\n" "Thank you for using this application!", style: TextStyle(fontSize: 20,),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}