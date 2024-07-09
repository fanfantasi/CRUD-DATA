import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/components/button.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class ConfirmPopUp extends StatelessWidget {
  const ConfirmPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersNotifier>(
      builder: (context, notifier, _) {
      return DraggableScrollableSheet(
          expand: false,
          maxChildSize: .9,
          initialChildSize: .25,
          builder: (_, controller) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 18.0,),
                    Text('Are You Sure ?', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontWeight: FontWeight.w400),),
                    const SizedBox(height: 32.0,),
                    buttonLoading(context, label: 'DELETE NOW', 
                    controller: notifier.btnController,
                    onPressed: () {
                      notifier.autoFillData();
                      // 
                      notifier.delete(context).then((value) {
                        if (value){
                          notifier.btnController.reset();

                          Future.delayed(const Duration(milliseconds: 300),(){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.userdelete);
                          });
                        }
                      });
                    },)
                  ]
                ),
              )
            );
          }
      );
    });
  }
}