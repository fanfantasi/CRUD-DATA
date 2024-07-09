import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/components/loadmore.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  ScrollController scrollController = ScrollController();
  late UsersNotifier notifier;
  @override
  void initState() {
    notifier = context.read<UsersNotifier>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.refreshLocalData();
    });
    super.initState();
  }

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
            await notifier.refreshLocalData();
          },
          onLoadmore: () async {},
          noMoreWidget: Container(),
          child: notifier.userLocal.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text(
                    'Empty selected user',
                    style: TextStyle(color: blackColor60),
                  )),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Total ${notifier.userLocal.length} items',
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
    for (var i = 0; i < notifier.userLocal.length; i++) {
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
                child: Image.network(notifier.userLocal[i].avatar ?? '',
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
                      '${notifier.userLocal[i].firstname ?? ''} - ${notifier.userLocal[i].lastname ?? ''}',
                      style: const TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      notifier.userLocal[i].email ?? '',
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
                    child: const Text('Delete'),
                    onTap: () {
                      notifier.deleteLocal(notifier.userLocal[i]);
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
