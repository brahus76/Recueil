import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _modeSombre = false;
  bool _defilementSync = true;
  bool _audioHorsLigne = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            Text("03 — PRÉFÉRENCES",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.clay)),
            const SizedBox(height: 4),
            Text("Paramètres", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 22),
            _SectionLabel("Lecture"),
            _SwitchRow(
              titre: "Mode sombre",
              sousTitre: "Pour les répétitions en soirée",
              valeur: _modeSombre,
              onChanged: (v) => setState(() => _modeSombre = v),
            ),
            _SwitchRow(
              titre: "Faire défiler avec la voix soliste",
              sousTitre: "Paroles synchronisées à l'audio",
              valeur: _defilementSync,
              onChanged: (v) => setState(() => _defilementSync = v),
            ),
            const SizedBox(height: 18),
            _SectionLabel("Téléchargements"),
            _SwitchRow(
              titre: "Audio hors-ligne",
              sousTitre: "Garder les 4 voix sur l'appareil",
              valeur: _audioHorsLigne,
              onChanged: (v) => setState(() => _audioHorsLigne = v),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String texte;
  const _SectionLabel(this.texte);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        texte.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String titre;
  final String sousTitre;
  final bool valeur;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.titre,
    required this.sousTitre,
    required this.valeur,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.creamDim,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2D8C1)),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        activeThumbColor: AppColors.teal,
        title: Text(titre, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
        subtitle: Text(sousTitre, style: const TextStyle(fontSize: 11.5, color: AppColors.inkSoft)),
        value: valeur,
        onChanged: onChanged,
      ),
    );
  }
}