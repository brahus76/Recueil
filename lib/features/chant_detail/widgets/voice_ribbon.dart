
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recueil/core/theme/app_colors.dart';

class VoiceRibbon extends StatelessWidget{
  final String nom;
  final Color couleur;
  final bool muet;
  final VoidCallback onTap;

  const VoiceRibbon({super.key, required this.nom, required this.couleur, required this.muet, required this.onTap});

  @override
  Widget build(BuildContext context){
    return AnimatedOpacity(
        opacity: muet ? 0.35 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 22,
                  decoration: BoxDecoration(
                    color: couleur,
                    borderRadius: BorderRadius.circular(3)
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 60,
                  child: Text(
                    nom,
                    style: const TextStyle(
                      color: AppColors.cream,
                      fontWeight: FontWeight.w600,
                      fontSize: 12
                    ),
                  ),
                ),
                // Barres simulant une forme d'onde — remplacées par une vraie
                // visualisation audio quand just_audio sera branché.
                Expanded(
                    child: Row(
                      children: List.generate(18, (i){
                        final h = 4.0 +((i * 37) % 16);
                        return Container(
                          width: 2.5,
                          height: h,
                          margin: const EdgeInsets.only(right: 2.5),
                          decoration: BoxDecoration(
                            color: couleur,
                            borderRadius: BorderRadius.circular(2)
                          ),
                        );
                      }),
                    )
                ),
                Icon(
                  muet ? Icons.volume_off : Icons.volume_up,
                  size: 16,
                  color: Color(0xFF9AA1C4),
                )
              ],
            ),
          ),
        ),
    );
  }
}