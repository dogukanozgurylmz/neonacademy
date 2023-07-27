import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LinkView extends StatefulWidget {
  const LinkView({super.key});

  @override
  State<LinkView> createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    if (deepLink != null) {
      setState(() {
        // Handle deepLink here
        print(deepLink.toString());
      });
    }
  }

  void shareLink(Uri myDynamicLink) {
    // [START ddl_share_link]
    final String msg = "Hey, check this out: $myDynamicLink";
    // Share.share(msg);
    // [END ddl_share_link]
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Links Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var dynamicLink =
                await FirebaseDynamicLinks.instance.getDynamicLink(
              Uri.parse('https://www.example.com/'),
            );
            if (dynamicLink != null) {
              shareLink(dynamicLink.link);
            }
          },
          child: Text('Share Link'),
        ),
      ),
    );
  }
}
