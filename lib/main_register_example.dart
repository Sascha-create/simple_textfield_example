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
  // EditingController einbauen um an den Text zu kommen

  final TextEditingController passwordController = TextEditingController();

//-------------------------------------------------------//

  // Braucht man das man alle Textfelder validieren kann
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? isEmailValid(String? value) {
    if (value == null) return "keine Email"; // null muss geprüft immer werden
    if (value.length < 5) return "Email zu kurz";
    if (value.length > 30) return "Email zu lang";
    if (value.contains("@")) return null;
    if (value.contains(".")) return null;
    return null;
  }

  String? isValidPassword(String? value) {
    if (value == null) return "kein Passwort"; // null muss geprüft immer werden
    if (value.length < 5) return "Passwort zu kurz";
    if (value.length > 15) return "Passwort zu lang";

    return null;
  }

  String? isConfirmPassword(String? value) {
    if (value == null) return "Kein Passwort";
    if (value != passwordController.text) return "Passwort nicht gleich";
    if (value == passwordController.text) return null;
    return null;
  }

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
            child: Form(
              key: _formKey, // formkey der Form übergeben
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(style: TextStyle(fontSize: 32), "New Account"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value != null &&
                            (value.length < 5 || value.length > 15)) {
                          return "Mehr als 5 Zeichen";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: isEmailValid,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(Icons.remove_red_eye),
                        border: OutlineInputBorder(),
                      ),
                      controller: passwordController,
                      validator: isValidPassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.visibility)),
                        border: OutlineInputBorder(),
                      ),
                      validator: isConfirmPassword,
                    ),
                  ),
                  Builder(builder: (context) {
                    // Button mit Builder wrappen dass Snackbar geht
                    return OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Alle Felder validiert")));
                          }
                        },
                        child: const Text("Create Account"));
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
