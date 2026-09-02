import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PaginationBar extends StatelessWidget {
  final int pageActuelle;
  final int totalPages;
  final ValueChanged<int> onPageChange;

  const PaginationBar({
    super.key,
    required this.pageActuelle,
    required this.totalPages,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.creamDim, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: pageActuelle > 1 ? () => onPageChange(pageActuelle - 1) : null,
            child: const Text("Préc.", style: TextStyle(color: AppColors.clay, fontSize: 12)),
          ),
          for (int p = 1; p <= totalPages; p++)
            _PageButton(
              numero: p,
              actif: p == pageActuelle,
              onTap: () => onPageChange(p),
            ),
          TextButton(
            onPressed: pageActuelle < totalPages ? () => onPageChange(pageActuelle + 1) : null,
            child: const Text("Suiv.", style: TextStyle(color: AppColors.clay, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final int numero;
  final bool actif;
  final VoidCallback onTap;

  const _PageButton({required this.numero, required this.actif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: actif ? AppColors.indigo : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$numero",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: actif ? AppColors.cream : AppColors.inkSoft,
            ),
          ),
        ),
      ),
    );
  }
}