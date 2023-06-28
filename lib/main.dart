import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mundeuk_app/permission_view.dart';
import 'package:mundeuk_app/web_view_stack.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!(await permissionCheck())) {
    exit(0);
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    MaterialApp(
        theme: ThemeData(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => WebViewStack(context),
          '/permission': (context) => PermissionViewStack(context),
        }),
  );
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
