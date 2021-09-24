import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  WebViewXController? webviewController;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // webviewController.loadContent("https://www.google.com/", SourceType.url)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: "enter url",
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (webviewController != null) {
                  webviewController!
                      .loadContent(textEditingController.text, SourceType.url);
                }
              },
              child: Text("load")),
          WebViewX(
            initialContent: 'https://www.youtube.com/embed/KtRVappi-DA',
            initialSourceType: SourceType.url,
            onWebViewCreated: (controller) => webviewController = controller,
            height: 500,
            width: 1000,
            onPageFinished: (s) {
              webviewController!.evalRawJavascript(
                  "console.log(document.getElementsByClassName('ytp-large-play-button ytp-button'))");
            },
          ),
        ],
      ),
    );
  }
}
