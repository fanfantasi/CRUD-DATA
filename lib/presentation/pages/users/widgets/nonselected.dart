import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/components/loadmore.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/data/models/index.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class NonSelectedPage extends StatefulWidget {
  const NonSelectedPage({super.key});

  @override
  State<NonSelectedPage> createState() => _NonSelectedPageState();
}

class _NonSelectedPageState extends State<NonSelectedPage> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersNotifier>(builder: (context, notifier, _) {
      return RefreshLoadmore(
          scrollController: scrollController,
          isLastPage: notifier.isLastpage,
          onRefresh: () async {
            notifier.page = 0;
            notifier.isLastpage = false;
            notifier.isLoadmore = false;
            await notifier.getUser();
          },
          onLoadmore: () async {
            if (notifier.isLoadmore) {
              return;
            }

            setState(() {
              notifier.isLoadmore = true;
            });

            notifier.page++;

            await notifier.getLoadMore();
            Future.delayed(const Duration(seconds: 1), () {
              notifier.isLoadmore = false;
            });
          },
          child: (notifier.isInitialPage && notifier.isloading)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Total ${notifier.totalpage} items',
                          style: const TextStyle(color: blackColor40)),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: widgetGenerate(notifier),
                    )
                  ],
                ));
    });
  }

  List<Widget> widgetGenerate(UsersNotifier notifier) {
    List<Widget> widget = [];
    for (var i = 0; i < notifier.users.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: blackColor60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(notifier.users[i].avatar ?? '',
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      '${notifier.users[i].firstname ?? ''} - ${notifier.users[i].lastname ?? ''}',
                      style: const TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      notifier.users[i].email ?? '',
                      style: const TextStyle(color: primaryColor),
                    )
                  ],
                ),
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz_outlined),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              offset: const Offset(0.0, 12),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: const Text('Select'),
                  onTap: () {
                    notifier.selectUser(notifier.users[i] as ResultUserModel);
                  },
                ),
                PopupMenuItem(
                    child: const Text('Update'),
                    onTap: () {
                      notifier.selectedData = notifier.users[i];
                      Navigator.pushNamed(context, Routes.usercreate,
                          arguments: 'edited');
                    }),
                PopupMenuItem(
                    child: const Text('Delete'),
                    onTap: () {
                      notifier.selectedData = notifier.users[i];
                      notifier.showButtomSheetConfirm(context);
                    }),
              ],
            )
          ],
        ),
      );
      widget.add(item);
    }
    return widget;
  }
}
