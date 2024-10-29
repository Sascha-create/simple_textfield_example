import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String inputValue = "Noch nichts";
  List<String> sentMessages = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: sentMessages.length,
                      itemBuilder: (context, index) => Card(
                            child: Text("${sentMessages[index]}"),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String newValue) {
                      print("der neue Wert ist $newValue");
                      inputValue = newValue;
                      setState(() {});
                    },
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        sentMessages.add(inputValue);
                      });
                    },
                    child: Text("Hinzufügen"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
