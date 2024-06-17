import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushTo<T>(BuildContext context, String location, {dynamic extra}) async {
  context.push(location, extra: extra);
}

void goTo<T>(BuildContext context, String location, {dynamic extra}) async {
  context.go(location, extra: extra);
}

void pushReplacementTo<T>(BuildContext context, String location,
    {dynamic extra}) {
  context.pushReplacement(location, extra: extra);
}

void pushToAndClearStack(BuildContext context, String location,
    {dynamic extra}) {
  int limit = 5;
  while (context.canPop() == true && limit != 0) {
    context.pop();
    limit--;
  }
  context.go(location, extra: extra);
}

void pop<T>(BuildContext context, [T? value]) {
  return context.pop(value);
}

void popUntil(BuildContext context, Type page) {
  return Navigator.popUntil(context, ModalRoute.withName(page.toString()));
}
