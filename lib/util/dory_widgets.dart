import 'package:flutter/cupertino.dart';

import 'dory_constants.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          //크기를 최대한 줄여줌
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
