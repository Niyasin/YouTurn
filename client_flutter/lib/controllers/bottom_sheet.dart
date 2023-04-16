import 'package:flutter/material.dart';

class BottomDragSheet extends StatelessWidget {
  DraggableScrollableController bottomSheetController =
      DraggableScrollableController();
  BottomDragSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_upward),
            label: Text("Click")),
      ],
    );
  }
}
