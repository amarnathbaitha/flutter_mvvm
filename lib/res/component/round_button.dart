import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/color.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundedButton({super.key,required this.title,this.loading = false, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(color: AppColors.buttonColor,borderRadius: BorderRadius.circular(10),),
        child: Center(child: loading?const CircularProgressIndicator(color: Colors.white,):Text(title,style: const TextStyle(color: AppColors.whiteColor),),),

      ),
    );
  }
}
