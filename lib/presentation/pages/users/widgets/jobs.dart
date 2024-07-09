import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class JobsPopUp extends StatelessWidget {
  const JobsPopUp({super.key});

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
                  children: List.generate(notifier.jobs.length, (index) => ListTile(
                    title: Text(notifier.jobs[index].label, style: TextStyle(color: notifier.jobs[index].selected ? primaryColor : blackColor),),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: ()  {
                      for (var i = 0; i < notifier.jobs.length; i++) {
                        notifier.jobs[i].selected = false;
                      }
                      notifier.jobs[index].selected = true;
                      notifier.textJobController.text = notifier.jobs[index].label;
                      Navigator.pop(context);
                    },
                  ),
                  )
                ),
              )
            );
          }
      );
    });
  }
}