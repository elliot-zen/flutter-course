import 'dart:developer';

import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置百度地图隐私政策
  BMFMapSDK.setAgreePrivacy(true);
  LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
  myLocPlugin.setAgreePrivacy(true);

  // Only for Android, initialize the location service
  await BMFAndroidVersion.initAndroidVersion();
  BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);

  // 请求位置权限
  await requestPermission();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme,
      home: PlaceScreen(),
    );
  }
}

Future<void> requestPermission() async {
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    log("=> Location permission granted");
  } else {
    log("=> Location permission not granted");
  }
}

Future<bool> requestLocationPermission() async {
  var status = await Permission.location.status;
  log("=> Location permission status: $status");

  if (status == PermissionStatus.granted) {
    return true;
  } else if (status == PermissionStatus.denied) {
    // 首次请求权限
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      log("=> Location permission granted after request");
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      log("=> Location permission permanently denied, opening settings");
      // 权限被永久拒绝，引导用户去设置页面
      await openAppSettings();
      return false;
    } else {
      log("=> Location permission denied");
      return false;
    }
  } else if (status == PermissionStatus.permanentlyDenied) {
    log("=> Location permission permanently denied, opening settings");
    // 权限被永久拒绝，引导用户去设置页面
    await openAppSettings();
    return false;
  } else {
    log("=> Location permission status: $status");
    return false;
  }
}
