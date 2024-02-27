import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

customSuccessToast(String title, String description, context) {
  return CherryToast.success(
    title: Text(title),
    enableIconAnimation: false,
    displayTitle: false,
    description: Text(description),
    animationType: AnimationType.fromBottom,
    toastPosition: Position.bottom,
    animationDuration: const Duration(milliseconds: 1000),
    autoDismiss: true,
  ).show(context);
}

customWarningToast(String title, String description, context) {
  return CherryToast.warning(
    title: Text(title),
    enableIconAnimation: false,
    displayTitle: false,
    description: Text(description),
    animationType: AnimationType.fromBottom,
    toastPosition: Position.bottom,
    animationDuration: const Duration(milliseconds: 1000),
    autoDismiss: true,
  ).show(context);
}

customErrorToast(String title, String description, context) {
  return CherryToast.error(
    title: Text(title),
    enableIconAnimation: false,
    displayTitle: false,
    description: Text(description),
    animationType: AnimationType.fromBottom,
    toastPosition: Position.bottom,
    animationDuration: const Duration(milliseconds: 1000),
    autoDismiss: true,
  ).show(context);
}
