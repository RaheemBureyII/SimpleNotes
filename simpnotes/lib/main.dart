import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simpnotes/widgets/noteslist.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
      appBar: AppBar(title: Text("Simple Notes"),),
      body: Center(child: Text("ERRORRR!!!!"),),
    );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
      appBar: AppBar(title: Text("Simple Notes"),),
      body: Center(child: Text("Loading"),),
    );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Notes"),),
      body: NotesList(),
    );
  }
}

