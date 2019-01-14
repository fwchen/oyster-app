import 'package:flutter/material.dart';
import 'package:osyter_app/model/Feed.dart';
import 'package:osyter_app/screens/feed_detail/feed_detail_screen.dart';

typedef OnBack = void Function(Feed feed);

class FeedListItem extends StatefulWidget {
  FeedListItem({Feed feed, this.onBack})
      : feed = feed,
        super();

  Feed feed;
  OnBack onBack;

  @override
  createState() => new FeedListItemState();
}

class FeedListItemState extends State<FeedListItem> {
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFavorite = widget.feed.marks.length > 0;
    });
  }

  _handleIconTap() async {
    if (!isFavorite) {
      await widget.feed.markFeedFavorite();
    }
    setState(() {
      isFavorite = widget.feed.marks.length > 0;
    });
  }

  _handleTap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedDetailPage(feed: widget.feed),
      ),
    );
    widget.onBack(widget.feed);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.feed.title),
        trailing: IconButton(
            icon: new Icon(isFavorite ? Icons.star : Icons.star_border,
                size: 30, color: Colors.amber),
            onPressed: _handleIconTap),
        onTap: () {
          _handleTap(context);
        });
  }
}
