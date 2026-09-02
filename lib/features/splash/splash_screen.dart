import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recueil/core/theme/app_colors.dart';
import 'package:recueil/features/chants/chants_list_screen.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.indigo,
      body: Stack(
        children: [
          _buildStripes(),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(32, 24, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Image.asset("assets/icon/splash_logo.png", width: 200,),
                      const SizedBox(height: 18,),
                      Text(
                        "Les chants de la chorale, en français et en mooré, "
                            "avec chaque voix à écouter séparement.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFD9D2BF),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28,),
                      _EnterButton(
                        onPressed: ()=> context.go('/chants/fr'),
                      ),
                    ],
                  ),
              )
          )
        ],
      ),
    );
  }
}

Widget _buildStripes(){
  return Positioned.fill(
    child: ClipRect(
      child: Transform.rotate(
        angle: -0.18,
          child: Center(
            child: SizedBox(
              width: 900,
              height: 1400,
              child: Row(
                children: List.generate(20, (i) {
                  return Expanded(
                    child: Container(
                      color: i.isEven
                        ? AppColors.indigo
                        : AppColors.indigoLight.withOpacity(0.4),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );

}
class _EnterButton extends StatelessWidget{
  final VoidCallback onPressed;
  const _EnterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.indigo,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 6,
          shadowColor: AppColors.gold.withOpacity(0.5)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Entrer",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5)),
            SizedBox(width: 8,),
            Icon(Icons.arrow_forward, size: 16,)
          ],
        )
    );
  }
}
