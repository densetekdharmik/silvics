import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/services.dart';
import '../values/const_urls.dart';

class InquireyPage extends StatefulWidget {
  const InquireyPage({Key? key}) : super(key: key);

  @override
  State<InquireyPage> createState() => _InquireyPageState();
}

class _InquireyPageState extends State<InquireyPage> {
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
          initialUrl: ConstUrls.webUrl,
          onWebViewCreated: (controller) {
            this.controller = controller;
            log("Current URL" + controller.currentUrl().toString());
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (url.contains(ConstUrls.webUrl)) {
                controller.runJavascript(
                    "var head = document.getElementsByClassName('main-header header-style-two')[0];" +
                        "head.remove();" +
                        "var cour = document.getElementsByClassName('carousel slide')[0];" +
                        "cour.remove();" +
                        "var about = document.getElementsByClassName('about-us')[0];" +
                        "about.remove();" +
                        "var footer = document.getElementsByClassName('main-footer')[0];" +
                        "footer.remove();"

                );
              }
              if (url.startsWith("https://api.whatsapp.com/")) {
                controller.loadUrl(ConstUrls.webUrl);
                Services.launchWhatsapp("9265314870");
              }
              if (url.startsWith("tel:")) {
                controller.loadUrl(ConstUrls.webUrl);
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
