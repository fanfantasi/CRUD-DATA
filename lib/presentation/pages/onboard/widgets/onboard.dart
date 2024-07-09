import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingWidget extends StatelessWidget {
  final String? title, description, image;
  const OnBoardingWidget({super.key,
    this.title,
    this.description,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          image??'assets/images/onboard.svg',
          height: 250,
        ),
        const SizedBox(height: kToolbarHeight,),
        descriptionOnBoard(
          context,
          title: title,
          description: description,
        ),
      ],
    );
  }

  Widget descriptionOnBoard (BuildContext context, {String? title, String? description}) {
    return Column(
      children: [
        Text(
          title??'',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16.0),
        Text(
          description??'',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}