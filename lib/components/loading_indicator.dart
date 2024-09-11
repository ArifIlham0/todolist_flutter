import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todolist_get/theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.isButton,
  });

  final bool? isButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeInOut(
        size: isButton == null ? 40 : 20,
        itemBuilder: (_, int index) {
          return isButton == null
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: index.isEven ? kPurple : kGrey,
                  ),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: index.isEven ? kWhite : kDarkGrey,
                  ),
                );
        },
      ),
    );
  }
}
