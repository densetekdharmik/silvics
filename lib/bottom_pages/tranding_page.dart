import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silvics/services/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../values/const_urls.dart';

class TrandingPage extends StatefulWidget {
  const TrandingPage({Key? key}) : super(key: key);

  @override
  State<TrandingPage> createState() => _TrandingPageState();
}

class _TrandingPageState extends State<TrandingPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        }
        Services.showConfirmDialog(context, "Are You Sure ?", () {
          SystemNavigator.pop();
        });
        return false;
      },
      child: Scaffold(
        body: WebView(
          initialUrl: ConstUrls.trendingUrl,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (url.contains(ConstUrls.trendingUrl)) {
                controller.runJavascript(
                    "var head = document.getElementsByClassName('main-header header-style-two')[0];" +
                        "head.remove();");
              }
              if (url.startsWith("https://api.whatsapp.com/")) {
                controller.loadUrl(ConstUrls.trendingUrl);
                Services.launchWhatsapp("9265314870");
              }
              if (url.startsWith("tel:")) {
                controller.loadUrl(ConstUrls.webUrl);
                Services.dialNumber("9265314870");
              }
            });
          },
        ),
      ),
    );
  }
}
