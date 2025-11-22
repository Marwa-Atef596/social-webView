import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/settings_cubit.dart';
import '../logic/settings_state.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final url = context.read<HomeCubit>().state.url;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.url.isNotEmpty) {
              _controller.loadRequest(Uri.parse(state.url));
            }
          },
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
