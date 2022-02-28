import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appSettingsProvider = ChangeNotifierProvider((ref) => AppSettingsModel());

class AppSettingsModel extends ChangeNotifier {
  bool _nightMode = false;

  bool _isAppInit = false;

  bool _userConnected = false;

  bool get userConnected => _userConnected;

  bool get isAppInit => _isAppInit;

  bool get nightMode => _nightMode;

  bool get isSideMenuOpen => showSideMenu;

  set nightMode(bool nightMode) {
    _nightMode = nightMode;
    notifyListeners();

    if (this.nightMode) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
      ));
    }
  }

  bool _sendNotifications = true;

  bool get sendNotifications => _sendNotifications;

  set sendNotifications(bool sendNotifications) {
    _sendNotifications = sendNotifications;
    notifyListeners();
  }

  AppSettingsModel() {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));
    _isAppInit = true;
    _userConnected = Random.secure().nextBool();
    notifyListeners();
  }

  void setAppInit(bool isAppInit) {
    _isAppInit = isAppInit;
    notifyListeners();
  }

  void setUserConnected(bool userConnected) {
    _userConnected = userConnected;
    notifyListeners();
  }

  final PageStorageKey _menuKey = const PageStorageKey<String>('sideMenu');

  final PageStorageBucket _bucket = PageStorageBucket();

  PageStorageKey get menuKey => _menuKey;

  PageStorageBucket get bucket => _bucket;

  bool _showSideMenu = true;

  bool get showSideMenu => _showSideMenu;

  set showSideMenu(bool showSideMenu) {
    _showSideMenu = showSideMenu;
    notifyListeners();
  }

  void toggleSideMenu() {
    _showSideMenu = !_showSideMenu;
    notifyListeners();
  }
}
