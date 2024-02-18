import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/form_widget.dart';
import '../models/user_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Main App",
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Main App"),
          ),
          body: Home(),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final name = "Kim Jong Chan";
  final id = "65130500222";
  final email = "kjchan@gmail.com";
  bool loggedIn = false;
  String loggedInText = "";

  User _user =
      User(id: 65130500222, name: "Kim Jong Chan", email: "kjchan@gmail.com");

  _updateUser(User newUser) {
    setState(() {
      _user = newUser;
    });
    _navigateAndReturn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        SizedBox(height: 20),
        FormWidget(updateUser: _updateUser),
        Text(loggedIn ? loggedInText : "Logged Out")
      ]),
    );
  }

  Future<void> _navigateAndReturn(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DisplayText(user: _user)),
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
    setState(() {
      loggedIn = true;
      loggedInText = result;
    });
  }
}

class DisplayText extends StatelessWidget {
  const DisplayText({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    void goBack(String text) {
      Navigator.pop(context, text);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => goBack("Go Back Default"),
        ),
        title: const Text("Display Text Page"),
      ),
      body: Expanded(
          child: Center(
        child: Column(
          children: [
            Text(user.name),
            Text(user.id.toString()),
            Text(user.email),
            ElevatedButton(
                onPressed: () => goBack("Go Back One"),
                child: const Text("Go Back One")),
            ElevatedButton(
                onPressed: () => goBack("Alternative Go Back"),
                child: const Text("Alternative Go Back"))
          ],
        ),
      )),
    );
  }
}
