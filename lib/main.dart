import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mundeuk_app/permission_view.dart';
import 'package:mundeuk_app/web_view_stack.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const WebViewApp(),
          '/web': (context) => WebViewStack(context),
          '/permission': (context) => PermissionViewStack(context),
        }),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<bool>(
            future: permissionCheck(),
            builder:
                (BuildContext context, AsyncSnapshot<bool> permissionResult) {
              if (permissionResult.data == null ||
                  permissionResult.data == false) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/permission");
                    },
                    child: Text("권한 허용하기"));
              } else {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/web",
                      );
                    },
                    child: const Text("웹 뷰 보기"));
              }
            }));
  }

  Future<bool> permissionCheck() async {
    final permissionList = [
      Permission.location,
      Permission.mediaLibrary,
      Permission.photos,
      Permission.notification,
    ];

    Map<Permission, PermissionStatus> statuses = await permissionList.request();

    return permissionList
        .map((permission) => statuses[permission] == PermissionStatus.granted)
        .reduce((acc, permission) => acc);
  }
}
