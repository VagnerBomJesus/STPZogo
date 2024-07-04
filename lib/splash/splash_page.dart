import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stpzogo/core/core.dart';
import 'package:stpzogo/home/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Definindo o temporizador para 3 segundos (3000 milissegundos)
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: AppColors.purple,
        child: Center(
          child: Stack(
            alignment: Alignment.center, // Centraliza o texto sobre a imagem
            children: [
              Image.asset(
                AppImages.logo,
              ), // A imagem de fundo
              Image.asset(
                AppImages.logo_n,
                width: 200,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'from',
                    style: AppTextStyles.bodyFron,
                  ),
                  Text(
                    'BJ Tech',
                    style: AppTextStyles.bodyLightGrey40,
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
