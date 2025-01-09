import 'package:flutter/material.dart';
import 'package:sca_shopper/services/cache_service.dart';
import 'package:sca_shopper/shared/Navigation/app_route_strings.dart';
import 'package:sca_shopper/shared/Navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRouter.navKey,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouteStrings.base,
      title: 'Flutter Demo',
    );
  }
}
