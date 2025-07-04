import 'package:flutter/material.dart';
import 'package:flutter_web_deploy/custom_path_strategy.dart';
import 'package:flutter_web_deploy/new_version_checker.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(CustomPathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(),
        '/deep': (context) => MyDeepPage(),
      },
      // builder: (context, child) {
      //   return Column(children: [NewVersionChecker(), Expanded(child: child!)]);
      // },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home!!")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NewVersionChecker(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/deep');
              },
              child: Text("Visit Deep Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDeepPage extends StatelessWidget {
  const MyDeepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deep")),
      body: Center(child: Text("This is so deep, brah.")),
    );
  }
}
