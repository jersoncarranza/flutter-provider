import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider2/src/pages/tabs_page.dart';
import 'package:provider2/src/services/news_service.dart';
import 'package:provider2/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewService(),
        )
      ],
      child: MaterialApp(title: 'Material App', home: TabsPage()),
    );
  }
}
