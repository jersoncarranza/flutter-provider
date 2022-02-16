import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider2/src/services/news_service.dart';
import 'package:provider2/src/widgets/lista_noticias.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewService>(context);
    // print('lisro $newsService');
    return Scaffold(
      //ListaNoticias(noticias: newsService.headLines),
      body: (newsService.headLines.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(noticias: newsService.headLines),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
