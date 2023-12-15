import 'package:flutter/material.dart';

/*
  The app_info.dart file is used to give a description of the application and
  give instructions on how to use it.
 */

// Used to populate Text widget with a description of what the application is and what it does
String info = "The NBA Player Index is a Flutter application that displays players pulled from balldontlie.io API. The purpose of this application is to be able to sort through players and view their data. Currently, the application contains NBA players from the 2023-2024 NBA season. The teams that are able to be viewed are:\n\nOrlando Magic\nBoston Celtics\nNew York Knicks\nToronto Raptors\nWashington Wizards\n\nThe players are displayed in a Card widget that tells you the player's name, the position they play, and an image of the team that they play for.";

class appInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Returns Expanded because this class is used in home.dart in which it populates the right half of the screen
    // The left half is used for the list view
    return Expanded(
      child: Container(
        color: Colors.lightBlue.shade50,
        child: Center(
          child: Column(
            children: [
              const Text(
                'NBA Player Index',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Formatting for the info string
                      Flexible(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              info,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      // Display the logo for all the teams in the application
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final team in ['orl', 'bos', 'nyk', 'tor', 'was'])
                            Image.asset(
                              '$team.png',
                              width: 100,
                              height: 100,
                            ),
                        ],
                      ),
                      // Finishing information/instruction
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "You can click on a player's card to read more details about that player.\n"
                              "You can also filter players by what team they play for using the dropdown menu at the top-left of the screen.\n\n"
                              "Thank you for using this application!",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
