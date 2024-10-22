import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/utils/init_app_util.dart';

import 'app.dart';

FutureOr<void> main() async {
  await InitAppUtil.init();
  runApp(const App());
}
