import 'package:flutter/material.dart';

Widget buildCharacterInfo({required String title, required String val}) {
  return RichText(
    text:TextSpan(
      children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
            text: val
        )
      ],
    ) ,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
