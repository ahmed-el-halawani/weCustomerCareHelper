import 'dart:io';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

class PCWindow {
  static void initWindow() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      DesktopWindow.setWindowSize(const Size(360, 700));
      DesktopWindow.setMinWindowSize(const Size(360, 700));
      DesktopWindow.setMaxWindowSize(const Size(360, 1000));
    }
  }
}
