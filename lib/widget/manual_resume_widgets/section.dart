import 'package:flutter/cupertino.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final int index;

  const Section(
      {super.key, this.title = "", required this.children, this.index = -1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
