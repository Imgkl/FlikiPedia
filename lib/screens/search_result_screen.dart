import 'package:flikipedia/custom_widgets/share.dart';
import 'package:flikipedia/custom_widgets/shimmer_image.dart';
import 'package:flikipedia/model/search_result.dart';
import 'package:flikipedia/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  final SearchResult searchResult;
  final String resultQuery;

  const SearchResultScreen({Key key, this.searchResult, this.resultQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchResultData = searchResult.query;
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, _) {
        return Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Results for '$resultQuery'"),
            backgroundColor: Colors.black,
          ),
          body: ListView.builder(
              itemCount: searchResult.query.pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    // color: DynamicColor().getColor(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        onLongPress: () {
                          HapticFeedback.heavyImpact();
                          share(context, searchResultData.pages[index].extract,
                              searchResultData.pages[index].url);
                        },
                        onTap: () {
                          launchURL(searchResultData.pages[index].url);
                        },
                        tileColor: Colors.white,
                        contentPadding: EdgeInsets.all(8.0),
                        leading: searchResultData.pages[index].thumbnail != null
                            ? searchResultData.pages[index] != null
                                ? CacheImage(
                                    url: searchResultData
                                        .pages[index].thumbnail.source,
                                  )
                                : Image.asset("assets/wiki_logo.png")
                            : Image.asset(
                                "assets/wiki_logo.png",
                                scale: 8,
                                height: 80,
                                width: 80,
                              ),
                        subtitle: Text(
                          searchResultData.pages[index].terms != null
                              ? searchResultData
                                  .pages[index].terms.description[0]
                              : "Description not available",
                        ),
                        title: Text(
                          searchResult.query.pages[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
