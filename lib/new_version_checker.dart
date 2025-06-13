import 'dart:async';
import 'dart:io';
import 'dart:html' as html;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const currentVersion = "0.0.12";

class NewVersionChecker extends StatefulWidget {
  const NewVersionChecker({super.key});

  @override
  State<NewVersionChecker> createState() => _NewVersionCheckerState();
}

class _NewVersionCheckerState extends State<NewVersionChecker> {
  Timer? versionCheckerTimer;

  @override
  void initState() {
    startVersionPolling();
    super.initState();
  }

  @override
  void dispose() {
    versionCheckerTimer?.cancel();
    super.dispose();
  }

  void startVersionPolling() {
    versionCheckerTimer?.cancel();
    versionCheckerTimer = Timer.periodic(Duration(seconds: 5), (_) async {
      final updateAvailable = await checkIfNewVersionIsAvailable();
      if (updateAvailable) {
        versionCheckerTimer?.cancel();
        if (context.mounted) {
          final shouldReload = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("New Version Available"),
                content: Text(
                  "A new version is available. Would you like to reload the page?",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("No thanks"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes please"),
                  ),
                ],
              );
            },
          );

          if (shouldReload == true) {
            // RELOAD PAGE FUNCTION
            html.window.location.reload();
          }
        }
      }
    });
  }

  Future<bool> checkIfNewVersionIsAvailable() async {
    final remote = await fetchRemoteVersion();
    if (remote != null && remote != currentVersion) {
      return true;
    }
    return false;
  }

  Future<String?> fetchRemoteVersion() async {
    final response = await Dio(
      BaseOptions(
        baseUrl: "https://flutter.lanesavery.com",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
          'Cache-Control': 'no-cache',
        },
      ),
    ).get("/version.json?t=${DateTime.now().millisecondsSinceEpoch}");

    return response.data?['version'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
