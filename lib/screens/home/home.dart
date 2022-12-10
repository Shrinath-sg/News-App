import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/search_news/search_news.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      getInitials();
    });
    super.initState();
  }

  getInitials() {
    context.read<NewsProvider>().getBreakingNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: NavigationBar(
            // height: 60,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.message),
                label: 'Breaking News',
              ),
              NavigationDestination(
                // selectedIcon: Icon(Icons.search),
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('News App'),
          ),
          body: <Widget>[
            newsProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      getInitials();
                    },
                    child: ListView.builder(
                      itemCount: newsProvider.breakingNews!.length,
                      itemBuilder: (context, index) {
                        final news = newsProvider.breakingNews![index];
                        return NewsCard(
                          news: news,
                        );
                      },
                    ),
                  ),
            const SearchNewsScreen(),
          ][currentPageIndex]),
    );
  }
}
