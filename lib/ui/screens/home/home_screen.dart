import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/ui/screens/home/provider/news_provider.dart';
import 'package:sport_house/ui/screens/home/provider/news_state.dart';
import 'package:sport_house/ui/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        _SearchBox(
                          onSearchTap: (searchQuery) {
                            //ref.read(newsProvider.notifier).performSearch(searchQuery);
                          },
                          onTextChange: (searchQuery) {
                            debugPrint("am currently searching for $searchQuery");
                            ref.read(newsProvider.notifier).performSearch(searchQuery);
                          },
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 30),
                            itemCount: newsState.articles.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (_, index) {
                              final newsArticle = newsState.articles[index];
                              return Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300, //New
                                        blurRadius: 10.0,
                                        offset: const Offset(10, 5))
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  newsArticle.urlToImage),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (newsArticle.title != null)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          newsArticle.title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 15),
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final Function(String) onSearchTap;
  final ValueChanged<String>? onTextChange;
  final searchController = TextEditingController();

  _SearchBox({Key? key, this.onTextChange, required this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.white400),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: searchController,
            onChanged: onTextChange,
            readOnly: false,
            decoration: InputDecoration(
              hintText: "Search",
              filled: true,
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
              contentPadding: const EdgeInsets.all(10.0),
              fillColor: AppColors.white400,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: InkWell(
              onTap: () {
                final searchQuery = searchController.text.trim();
                if (searchQuery.isNotEmpty) onSearchTap(searchQuery);
                //searchController.text = searchQuery;
              },
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0), color: Colors.blue.shade600),
                child: const Center(child: Icon(Icons.search_outlined, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
