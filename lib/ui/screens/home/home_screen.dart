import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/ui/screens/home/components/article_feed.dart';
import 'package:sport_house/ui/screens/home/provider/news_provider.dart';
import 'package:sport_house/ui/screens/home/provider/news_state.dart';

import 'components/home_screen_search_box.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NewsState newsState = ref.watch(newsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFCF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: newsState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : newsState.errorMessage != null
                  ? Center(child: Text(newsState.errorMessage!))
                  : Column(
                      children: [
                        HomeScreenSearchBox(
                          controller: searchController,
                          onTextChange: (value) {
                            if (value == null || value.isEmpty) {
                              ref.read(newsProvider.notifier).performSearch("");
                            }
                          },
                          onSearchTap: () {
                            final searchQuery = searchController.text.trim();
                            if (searchQuery.isEmpty) return;
                            ref.read(newsProvider.notifier).performSearch(searchQuery);
                          },
                        ),
                        Expanded(
                            child: ArticleFeed(
                          articles: newsState.newsArticleFeed,
                        ))
                      ],
                    ),
        ),
      ),
    );
  }
}
