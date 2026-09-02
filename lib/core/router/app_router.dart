import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../demo_data.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/chants/chants_list_screen.dart';
import '../../features/chant_detail/chant_detail_screen.dart';
import '../../features/settings/settings_screen.dart';

/// Construit une branche complète (liste + détail) pour une langue donnée.
/// Évite de dupliquer la structure de route pour fr et moore.
StatefulShellBranch _chantsBranch(String lang) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: '/chants/$lang',
        builder: (context, state) => ChantsListScreen(lang: lang),
        routes: [
          GoRoute(
            path: ':numero',
            builder: (context, state) {
              final numero = int.parse(state.pathParameters['numero']!);
              final chant = demoChantsFor(lang).firstWhere((c) => c.numero == numero);
              return ChantDetailScreen(
                numero: chant.numero,
                titre: chant.titre,
                nombreVoix: chant.voix,
              );
            },
          ),
        ],
      ),
    ],
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        _chantsBranch('fr'),
        _chantsBranch('moore'),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/parametres',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          // Si on retape sur l'onglet déjà actif, on revient à sa racine
          // (comportement classique : retaper "Français" remonte en haut de la liste).
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Français"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Mooré"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Paramètres"),
        ],
      ),
    );
  }
}