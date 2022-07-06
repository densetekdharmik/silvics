import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/services.dart';
import '../values/const_urls.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
          initialUrl: ConstUrls.contactUrl,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (url.contains(ConstUrls.contactUrl)) {
                controller.runJavascript(
                    "var head = document.getElementsByClassName('main-header header-style-two')[0];" +
                        "head.remove();");
              }
              if (url.startsWith("https://api.whatsapp.com/")) {
                controller.loadUrl(ConstUrls.contactUrl);
                Services.launchWhatsapp("9265314870");
              }
              if (url.startsWith("tel:")) {
                controller.loadUrl(ConstUrls.contactUrl);
                Services.dialNumber("9265314870");
              }
            });
          },
        ),
      ),
    );
  }
}
