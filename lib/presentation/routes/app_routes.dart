import 'package:flutter/material.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/presentation/app.dart';
import 'package:testing/presentation/pages/onboard/screen.dart';
import 'package:testing/presentation/pages/users/screen.dart';
import 'package:testing/presentation/pages/users/widgets/createupdate.dart';
import 'package:testing/presentation/pages/users/widgets/delete.dart';




class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
            builder: (_) => const AppPage(), settings: settings);
      
      case Routes.onboard:
        return MaterialPageRoute(
          builder: (_) => const OnBoardPage(), settings: settings);

      case Routes.userlist:
        return MaterialPageRoute(
          builder: (_) => const UsersPage(), settings: settings);
      
      case Routes.usercreate:
        return MaterialPageRoute(
          builder: (_) => const CreatePage(), settings: settings);
      
      case Routes.userdelete:
        return MaterialPageRoute(
          builder: (_) => const DeletePage(), settings: settings);

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
            title: const Text("Page Not Found")),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 24),
              Text('404'),
            ],
          ),
        ),
      );
    });
  }
}
