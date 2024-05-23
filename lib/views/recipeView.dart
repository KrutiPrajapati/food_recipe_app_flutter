import 'package:flutter/material.dart';
import 'package:foodrecipeapp/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeViewPage extends StatefulWidget {

  final String postUrl;

  const RecipeViewPage({super.key, required this.postUrl});

  @override
  State<RecipeViewPage> createState() => _RecipeViewPageState();
}

class _RecipeViewPageState extends State<RecipeViewPage> {

  late String finalUrl;

  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print("${finalUrl}this is final url");
    }

  }
   */

  @override
  Widget build(BuildContext context) {

    finalUrl = widget.postUrl;
    if (widget.postUrl.contains('http://')) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(finalUrl));

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,

      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),

    );
  }
}
