import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  Timer? _debounce;
  final TextEditingController? searchController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.resetNewsList = newsProvider.breakingNews;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,

                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Search News"),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          _onSearchChanged(val);
                        } else {
                          newsProvider.resetNewsList =
                              newsProvider.breakingNews;
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      // color: AppColors.burgundy,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(Icons.search_sharp)),
                ),
              ],
            ),
          ),
          newsProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsProvider.searchedNews!.length,
                  itemBuilder: (context, index) {
                    final news = newsProvider.searchedNews![index];
                    return NewsCard(
                      news: news,
                    );
                  },
                ),
        ],
      ),
    );
  }

  _onSearchChanged(String? query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.searchNews(query);
    });
  }

  @override
  void dispose() {
    searchController!.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
