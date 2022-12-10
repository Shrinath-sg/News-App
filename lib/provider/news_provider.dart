import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_services.dart';

class NewsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<NewsArticles?>? _breakingNews = [];
  List<NewsArticles?>? _searchedNews = [];

  List<NewsArticles?>? get breakingNews => [..._breakingNews ?? []];

  List<NewsArticles?>? get searchedNews => [..._searchedNews ?? []];

  getBreakingNews() async {
    try {
      isLoading = true;
      notifyListeners();
      _breakingNews = await NewsService.getAllBreakingNews();
    } catch (err) {
      log(err.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  searchNews(String? searchTerm) async {
    try {
      isLoading = true;
      notifyListeners();
      _searchedNews =
          await NewsService.searchNews(searchTerm: searchTerm ?? '');
    } catch (err) {
      log(err.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  set resetNewsList(newValue) {
    _searchedNews = newValue;
    notifyListeners();
  }
}
