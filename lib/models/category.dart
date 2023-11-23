// blueprint for category

import 'dart:core';
import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // this is fallback color
  });
  final String id;
  final String title;
  final Color color;
}
