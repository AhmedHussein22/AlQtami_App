import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(),
    initDI(),
    ScreenUtil.ensureScreenSize(),
  ]);

  Bloc.observer = AppBlocObserver();

  runApp(const AlqtamiApp());
}
