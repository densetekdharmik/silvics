import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/services.dart';
import '../values/const_urls.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gallery"
          ),
        ),
        body: WebView(
          initialUrl: ConstUrls.gallery,
          onWebViewCreated: (controller) {
            this.controller = controller;
            log("Current URL" + controller.currentUrl().toString());
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (url.contains(ConstUrls.gallery)) {
                controller.runJavascript(
                    "var head = document.getElementsByClassName('main-header header-style-two')[0];" +
                        "head.remove();"  +
                        "var f1 = document.getElementsByClassName('main-footer')[0];" +
                        "f1.remove();"
                );
              }
              if (url.startsWith("https://api.whatsapp.com/")) {
                controller.loadUrl(ConstUrls.homeUrl);
                Services.launchWhatsapp("9265314870");
              }
              if (url.startsWith("tel:")) {

                controller.loadUrl(ConstUrls.homeUrl);
                Services.dialNumber("9265314870");
              }
            });
            log("Current URL" + controller.currentUrl().toString());
          },
        ),
      ),
    );
  }
}
