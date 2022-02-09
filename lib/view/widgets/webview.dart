import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPageView extends StatelessWidget {
  final String url;
  final String title;
  // final String logoUrl;

  const WebPageView({
    Key? key,
    required this.url,
    required this.title,
    // required this.logoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: Styles.headlineText1,
          ),
        ),
        url: url,
        withJavascript: true,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        appCacheEnabled: true,
        allowFileURLs: true,
        initialChild: Loading.spinKitThreeBounce(),
      ),
    );
  }
}
