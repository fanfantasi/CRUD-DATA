import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/core/utils/routes.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(context, Routes.onboard, (route) => false);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/images/logo.svg',
        alignment: Alignment.centerLeft, fit: BoxFit.cover
        ),
      ),
    );
  }
}