import 'package:flutter/material.dart';

import '../../util/dory_widgets.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {super.key,
      required this.onPressedCamera,
      required this.onPressedGallery});

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedCamera,
          child: const Text('카메라로 촬영'),
        ),
        TextButton(
          onPressed: onPressedGallery,
          child: const Text('앨범에서 가져오기'),
        ),
      ],
    );
  }
}