

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recueil/core/theme/app_colors.dart';

class ChantRow extends StatelessWidget{
  final int numero;
  final String titre;
  final int nombreVoix;
  final VoidCallback onTap;

  const ChantRow({super.key, required this.numero, required this.titre, required this.nombreVoix, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                numero.toString().padLeft(2, '0'),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.clay
                ),
              ),
            ),
            const SizedBox(width: 14,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        for(int i = 0; i < nombreVoix ; i++)
                          Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: AppColors.voices[i],
                              shape: BoxShape.circle
                            ),
                          ),
                        const SizedBox(width: 4),
                        Text(
                            "$nombreVoix",
                            style: Theme.of(context).textTheme.labelSmall,
                        )

                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Colors.black26,),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}