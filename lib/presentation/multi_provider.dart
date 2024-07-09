
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:testing/presentation/privider/onboard/notifier.dart';
import 'package:testing/presentation/privider/users/notifier.dart';
import '../injection_container.dart' as di;

class AppDependencies {
  static List<SingleChildWidget> inject() => [
    ChangeNotifierProvider(create: (_) => di.getIt<OnBoardNotifier>()),
    ChangeNotifierProvider(create: (_) => di.getIt<UsersNotifier>()),
  ];
}