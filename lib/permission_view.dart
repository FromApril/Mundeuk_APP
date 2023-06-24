import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mundeuk_app/primary_button.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionViewStack extends StatefulWidget {
  const PermissionViewStack(BuildContext context, {super.key});

  @override
  State<PermissionViewStack> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionViewStack> {
  _PermissionViewState();

  PermissionStatus _permissionStatus = PermissionStatus.provisional;

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      ElevatedButton(
        onPressed: () async {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.location,
            Permission.mediaLibrary,
            Permission.photos,
            Permission.notification,
          ].request();
          print(statuses[Permission.location]);
        },
        child: Text("get Loation"),
      ),
    ]));
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();

    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }

    setState(() {
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }
}
