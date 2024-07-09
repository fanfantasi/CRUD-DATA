import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/core/utils/routes.dart';
import 'package:testing/presentation/routes/app_routes.dart';
import 'injection_container.dart' as di;
import 'presentation/multi_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppDependencies.inject(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: mainNavigatorKey,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
          color: whiteColor,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 16,
              color: blackColor),
          )
        ),
        title: 'TESTING APPS',
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.root,
      ),
    );
  }
}
