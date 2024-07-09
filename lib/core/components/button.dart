
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../utils/constants.dart';

Widget buttonColor(BuildContext context,{Function()? onPressed, String? label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: primaryColor),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: kToolbarHeight,
        child: Center(
          child: Text(label??'OK',
              textAlign: TextAlign.center),
        ),
      ),
    ),
  );
}

Widget buttonLoading(BuildContext context,{required RoundedLoadingButtonController controller, Function()? onPressed, String? label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: RoundedLoadingButton(
      animateOnTap: true,
      errorColor: primaryColor,
      controller: controller,
      onPressed: onPressed,
      borderRadius: 50,
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      color: primaryColor,
      child: Text(
        label??'OK',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 16.0,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget buttonText(BuildContext context,{Function()? onPressed, String? label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: kToolbarHeight,
        child: Center(
          child: Text(label??'OK',
              textAlign: TextAlign.center,
              style: const TextStyle(color: blackColor80),
            ),
        ),
      ),
    ),
  );
}