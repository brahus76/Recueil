import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import 'providers/chants_providers.dart';
import 'widgets/chant_row.dart';
import 'widgets/pagination_bar.dart';

class ChantsListScreen extends ConsumerWidget {
  final String lang;

  const ChantsListScreen({super.key, required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chants = ref.watch(paginatedChantsProvider(lang));
    final totalPages = ref.watch(totalPagesProvider(lang));
    final pageActuelle = ref.watch(currentPageProvider(lang));

    final titreAffiche = lang == 'fr' ? 'Français' : 'Mooré';
    final eyebrow = lang == 'fr' ? '01 — CHANTS EN FRANÇAIS' : '02 — CHANTS EN MOORÉ';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.clay,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(titreAffiche, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 14),
                  _SearchBar(lang: lang),
                ],
              ),
            ),
            Expanded(
              child: chants.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: chants.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1, color: AppColors.creamDim),
                itemBuilder: (context, index) {
                  final c = chants[index];
                  return ChantRow(
                    numero: c.numero,
                    titre: c.titre,
                    nombreVoix: c.voix,
                    onTap: () => context.push('/chants/$lang/${c.numero}'),
                  );
                },
              ),
            ),
            PaginationBar(
              pageActuelle: pageActuelle,
              totalPages: totalPages,
              onPageChange: (p) => ref.read(currentPageProvider(lang).notifier).state = p,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  final String lang;
  const _SearchBar({required this.lang});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamDim,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2D8C1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: AppColors.inkSoft),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Rechercher un chant, un numéro…",
                isDense: true,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (valeur) {
                ref.read(searchQueryProvider(lang).notifier).state = valeur;
                // Toute nouvelle recherche repart de la page 1.
                ref.read(currentPageProvider(lang).notifier).state = 1;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Aucun chant trouvé",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              "Essayez un autre titre ou un autre numéro.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}