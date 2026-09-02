import 'package:flutter/material.dart';
import 'package:recueil/features/chant_detail/widgets/voice_ribbon.dart';

import '../../core/theme/app_colors.dart';

class ChantDetailScreen extends StatefulWidget{
  final int numero;
  final String titre;
  final int nombreVoix;

  const ChantDetailScreen({
    super.key,
    required this.numero,
    required this.titre,
    required this.nombreVoix
  });

  @override
  State<ChantDetailScreen> createState() => _ChantDetailScreenState();
}

class _ChantDetailScreenState extends State<ChantDetailScreen>{
  static const _nomsVoix = ["Soprano", "Alto", "Ténor", "Basse"];
  late final List<bool> _muet = List.filled(widget.nombreVoix, false);
  bool _enLecture = false;
  bool _favori = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildLyrics(context)),
              _buildMixer(context)
            ],
          )
      ),
    );
  }

  Widget _buildHeader(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.creamDim, width: 1))
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, size: 20,)),
          const SizedBox(width: 6,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "N°${widget.numero.toString().padLeft(2, '0')}",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.clay),
                  ),
                  Text(
                    widget.titre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              )
          ),
          // L'icone qui permet de définir le favorie
          IconButton(
              onPressed: (){
                setState(() => _favori = !_favori);
              },
              icon: Icon(_favori ? Icons.favorite : Icons.favorite_border,
                color: _favori ? AppColors.clay : AppColors.inkSoft,
              )
          )
        ],
      ),
    );
  }
  Widget _buildLyrics(BuildContext context){
    // Paroles de démonstration — remplacées par le vrai contenu au Module 6.
    final couplets = [
      ("Couplet 1", "Voici des paroles d'exemple pour montrer la mise en page du chant, ligne après ligne."),
      ("Refrain", "Que nos voix s'unissent, ici, ce soir, en un seul chant."),
      ("Couplet 2", "Un second couplet vient prolonger le premier, toujours pensé pour rester lisible."),
    ];
    return ListView(
      padding:  const EdgeInsets.fromLTRB(24, 18, 24, 12),
      children: [
        for(final (label, texte) in couplets)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 0.5),
                ),
                const SizedBox(height: 6,),
                Text(
                  texte,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.5,
                    height: 1.7,
                    fontStyle: label == "Refrain" ? FontStyle.italic : FontStyle.normal,
                    color: label == "Refrain" ? AppColors.clay : AppColors.ink
                  ),
                ),

              ],
            ),
          )
      ],
    );
  }

  Widget _buildMixer(BuildContext context){
    return Container(
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "MÉLANGEUR DE VOIX",
                style: TextStyle(color: Color(0xFF9AA1C4), fontSize: 10, letterSpacing: 1),
              ),
              Text(
                "01:12 / 03:40",
                style: TextStyle(color: Color(0xFF9AA1C4), fontSize: 10.5),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.28,
              minHeight: 4,
              backgroundColor: const Color(0xFF333F6B),
              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
            ),
          ),
          const SizedBox(height: 14,),
          for(int i= 0; i < widget.nombreVoix ; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: VoiceRibbon(
                  nom: _nomsVoix[i],
                  couleur: AppColors.voices[i],
                  muet: _muet[i],
                  onTap: () =>setState(() => _muet[i] = !_muet[i])
              ),
            ),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Icon(Icons.skip_previous, color: AppColors.cream,),
              const SizedBox(width: 22,),
              InkWell(
                onTap: () => setState(() => _enLecture = !_enLecture),
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                  child: Icon(
                    _enLecture ? Icons.pause : Icons.play_arrow,
                    color: AppColors.indigo,
                  ),
                ),
              ),
              const SizedBox(width: 22,),
              const Icon(Icons.skip_next, color: AppColors.cream)
            ],
          )
        ],
      ),
    );
  }
}