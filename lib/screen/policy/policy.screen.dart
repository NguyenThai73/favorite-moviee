// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  InAppWebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF325A3E),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        leadingWidth: 50,
        title: const Text(
          "Privacy Policy and Terms",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 44,
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(),
          initialUrlRequest: URLRequest(url: WebUri("https://sites.google.com/view/privacy-policy-favorite-movie/trang-ch%E1%BB%A7")),
        ),
      ),
    );
  }
}
