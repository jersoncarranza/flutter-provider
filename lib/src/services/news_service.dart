import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider2/src/models/category_model.dart';
import 'package:provider2/src/models/news_service.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'c14cc88c791a43388a924b2c0f3f2876';

class NewService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewService() {
    getTopHeadLines();
    categories.forEach((item) {
      categoryArticles[item.name] = List.empty(growable: true);
      ;
    });
    getArticleByCategory(_selectedCategory);
  }

  bool get isLoading => this._isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(dynamic valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticleByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  getTopHeadLines() async {
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'category': _selectedCategory, 'country': 'mx', 'apiKey': _APIKEY});

    final resp = await http.get(uri);
    final newsResponse = NewsResponse.fromJson(resp.body);
    //print(newsResponse);
    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticleByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'category': _selectedCategory, 'country': 'mx', 'apiKey': _APIKEY});
    final resp = await http.get(uri);
    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}
