import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/demo_data.dart';

const chantsPerPage = 4;

/// Le texte de recherche, un état indépendant par langue.
final searchQueryProvider = StateProvider.family<String, String>((ref, lang) => '');

/// La page courante, un état indépendant par langue.
final currentPageProvider = StateProvider.family<int, String>((ref, lang) => 1);

/// Liste filtrée par la recherche — recalculée automatiquement
/// à chaque frappe dans la barre de recherche.
final filteredChantsProvider = Provider.family<List<ChantFake>, String>((ref, lang) {
  final query = ref.watch(searchQueryProvider(lang)).trim().toLowerCase();
  final tous = demoChantsFor(lang);

  if (query.isEmpty) return tous;

  return tous
      .where((c) =>
  c.titre.toLowerCase().contains(query) || c.numero.toString().contains(query))
      .toList();
});

/// Nombre total de pages pour la recherche courante.
final totalPagesProvider = Provider.family<int, String>((ref, lang) {
  final filtres = ref.watch(filteredChantsProvider(lang));
  if (filtres.isEmpty) return 1;
  return (filtres.length / chantsPerPage).ceil();
});

/// Les chants de la page courante uniquement.
final paginatedChantsProvider = Provider.family<List<ChantFake>, String>((ref, lang) {
  final filtres = ref.watch(filteredChantsProvider(lang));
  final page = ref.watch(currentPageProvider(lang));

  final debut = (page - 1) * chantsPerPage;
  if (debut >= filtres.length) return [];

  final fin = (debut + chantsPerPage).clamp(0, filtres.length);
  return filtres.sublist(debut, fin);
});