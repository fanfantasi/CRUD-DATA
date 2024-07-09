import 'package:flutter/material.dart';
import 'package:testing/core/components/button.dart';
import 'package:testing/core/utils/constants.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_sharp, size: kToolbarHeight * 2, color: primaryColor,),
          const SizedBox(height: 16.0,),
          Text('Delete Successfully', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontWeight: FontWeight.w400),),
          const SizedBox(height: 16.0,),
          buttonColor(context, label: 'OK', onPressed: ()=> Navigator.pop(context))
        ],
      ),
    );
  }
}