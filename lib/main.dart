import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main(){
  runApp(
      const ProviderScope(child: RecueilApp())
  );
}
class RecueilApp extends StatelessWidget{
  const RecueilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      title: "Recueil",
      routerConfig: appRouter,
    );
  }
}