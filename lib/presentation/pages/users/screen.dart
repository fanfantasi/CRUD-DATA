import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/presentation/pages/users/widgets/nonselected.dart';
import 'package:testing/presentation/pages/users/widgets/selected.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with SingleTickerProviderStateMixin {
  late UsersNotifier notifier;

  @override
  void initState() {
    notifier = context.read<UsersNotifier>();
    notifier.tabController =
        TabController(vsync: this, length: notifier.tabs.length);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.getUser();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (notifier.tabController != null) {
      notifier.tabController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersNotifier>(builder: (context, notifier, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.usercreate, arguments: 'create'),
              icon: const CircleAvatar(
                backgroundColor: blackColor20,
                child: Icon(
                  Icons.add,
                  color: blackColor,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: notifier.tabController,
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w400),
                  unselectedLabelColor: blackColor,
                  isScrollable: true,
                  tabs: notifier.tabs,
                ),
              ),
            ),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: TabBarView(controller: notifier.tabController, children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: NonSelectedPage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SelectedPage(),
            ),
          ]),
        ),
      );
    });
  }
}
